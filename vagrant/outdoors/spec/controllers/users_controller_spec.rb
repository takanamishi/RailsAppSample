require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  describe "会員登録前" do
    describe "GET new" do
      before do
        get :new
      end

      it "サクセスすること" do
        expect(response).to be_success
      end

      it "users/newを描画すること" do
        expect(response).to render_template("users/new")
      end
    end
  end

  describe "会員登録後" do
    fixtures :users

    before do
      @user = users(:testuser)
      login_user(@user)
    end

    describe "GET new" do
      it "ログイン中はスポット情報ページにリダイレクトすること" do
        get :new

        expect(response).to redirect_to spots_url
      end
    end

    describe "GET edit" do
      before do
        get :edit, id: @user
      end

      it "サクセスすること" do
        expect(response).to be_success
      end

      it "@userにはidで指定したuser情報がロードされていること" do
        expect(assigns(:user)).to eq(@user)
      end

      it "user/edit/:idを描画すること" do
        expect(response).to render_template :edit
      end
    end

  end
end