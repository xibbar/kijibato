require 'spec_helper'

describe ArticlesController do
  fixtures :all
  before do
  end
  describe "#loginのテスト" do
    context "get #login" do
      it "ログイン画面が表示される" do
        get :login, initial: 'group00'
        response.should be_success
      end
    end
    context "post #login" do
      it "正しいメールアドレスがPOST" do
        post :login, initial: 'group00', email: 'user00@example.com'
        flash[:notice].should be_true
        flash[:error].should be_nil
        response.should redirect_to login_articles_path
      end
      it "正しいメールアドレスだけどログインキーが期限切れがPOST" do
        user=users(:user00)
        user.key_expire_at=0
        user.save
        post :login, initial: 'group00', email: 'user00@example.com'
        flash[:notice].should be_true
        flash[:error].should be_nil
        response.should redirect_to login_articles_path
      end
      it "間違ったメールアドレスがPOST" do
        post :login, initial: 'group00', email: 'user00@example.co'
        flash[:notice].should be_nil
        flash[:error].should be_true
        response.should redirect_to login_articles_path
      end
    end
  end
  describe "#indexのテスト" do
    context "get #index" do
      it "グループのみの場合はリダイレクト" do
        get :index, initial: 'group00'
        response.should redirect_to login_articles_path
      end
      it "メールアドレスとキーが正しい場合" do
        get :index, initial: 'group00', m: 'user00@example.com', l: 'aabbccdd'
        response.should be_success
      end
      it "キーが間違っている場合" do
        get :index, initial: 'group00', m: 'user00@example.com', l: 'aabbccff'
        response.should redirect_to(login_articles_path)
      end
      it "キーが期限切れ" do
        user=users(:user00)
        user.key_expire_at=0
        oldkey=user.login_key.dup
        user.save
        get :index, initial: 'group00', m: 'user01@example.com', l: 'AABBCCDD'
        response.should redirect_to(login_articles_path)
        user.reload
        user.login_key.should_not == "AABBCCDD"
        user.key_expire_at.should be > Time.now
      end
    end
  end
end
