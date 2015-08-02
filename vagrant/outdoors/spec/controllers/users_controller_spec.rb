require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  # fixtures :users

  before do
    @user = User.new(email: "test@example.com", password: "abcd1234", password_confirmation: "abce1234")
  end

  after do
  end

  describe "GET new" do
    it "サクセスすること" do
      get :new

      expect(response).to be_success
    end

    it "users/newを描画すること" do
      @user = User.new
      get :new

      expect(response).to render_template("users/new")
    end

    it "新規会員登録に成功したらスポット情報ページに遷移すること" do

    end

    it "ログイン中はスポット情報ページにリダイレクトすること" do
      fixtures :users
      @user = users(:testuser)
      login_user(@user)
      get :new

      expect(response).to redirect_to spots_url
    end
  end
end