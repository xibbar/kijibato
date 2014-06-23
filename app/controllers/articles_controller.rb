class ArticlesController < ApplicationController
  before_action :set_group
  before_action :set_user, except: :login
  before_action :check_login_key_expire, except: :login

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.where(group: @group).order('id desc').page(params[:page]).per(5)
  end

  def login
    default_url_options[:email] = nil
    if request.method=='POST'
      @user=User.find_by(group_id: @group.id, email: params[:email])
      redirect_to articles_path(email: params[:email]) if @user
    end
  end

  def new
    @article = Article.find_by(group: @group, id: params[:id])
    if @article
      @article.comment=@article.comment.split(/\n/).map{|val|
        "> "+val
      }.join("\n")+"\n"
      @article.title="Re: "+@article.title
      @article.title.gsub!(/^(Re:\s{0,1}){2,}(.*)/){"Re:Re: #{$2}"}
    end

    @article = Article.new unless @article
    @article.name = @user.name
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)
    @article.user = @user
    @article.group = @group
    @article.user_agent=request.env['HTTP_USER_AGENT']
    @article.host=request.env['REMOTE_HOST']
    @article.ip=request.env['REMOTE_ADDR']

    if @article.save
      users = User.where(group_id: @group.id)
      users.each do |user|
        Notifier.article(articles_path(email: user.email, l: user.login_key, only_path: false), user.email).deliver
      end
      redirect_to articles_path, notice: 'Article was successfully created.'
    else
      render :new 
    end
  end

  private
  def set_group
    @group = Group.find_by(initial: params[:initial])
    if @group
      default_url_options[:initial] = @group.initial
    else
      default_url_options[:initial] = nil
      default_url_options[:email] = nil
      flash[:error] = "Invalid Group"
      redirect_to root_path unless @group
    end
  end

  def set_user
    @user=User.find_by(email: params[:m], login_key: params[:l], group_id: @group.id)
    if @user
      default_url_options[:m] = @user.email
      default_url_options[:l] = @user.login_key
    else
      default_url_options[:m] = nil
      default_url_options[:l] = nil
      flash[:error] = "Invalid User"
      redirect_to login_articles_path unless @user
    end
  end

  def check_login_key_expire
    now = Time.now
    if @user.key_expire_at < now
      @user.generate_login_key
      Notifier.article(articles_path(email: @user.email, l: @user.login_key, only_path: false), @user.email).deliver
      flash[:notice] = "You Login key was expired. Your New Login URL was sent to your email address."
      redirect_to login_articles_path
    end
  end

  def article_params
    params.require(:article).permit(:group_id, :user_id, :host, :ip, :user_agent, :title, :comment, :name)
  end

end
