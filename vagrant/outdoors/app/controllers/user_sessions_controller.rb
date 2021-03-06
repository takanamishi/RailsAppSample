class UserSessionsController < ApplicationController
  skip_before_filter :require_login, except: [:destory]

  def new
    @user = User.new
  end

  def create
    email = params_user[:email]
    password = params_user[:password]

    if login(email, password)
      redirect_to spots_path, notice: "ログインに成功しました。"
    else
      @user = User.new(email: email)
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_url, notice: "ログアウトしました。"
  end

  private

  def params_user
    params.require(:user).permit(:email, :password)
  end
end