class ArticlesController < ApplicationController
  before_action :set_group

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.where(group: @group).order('id desc').page(params[:page]).per(5)
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_group
      @group = Group.find_by_initial(params[:initial])
    end

    def article_params
      params.require(:article).permit(:group_id, :user_id, :host, :ip, :user_agent, :title, :comment)
    end

    def default_url_options
      {initial: @group.initial}
    end
end
