class ApplicationController < ActionController::Base
  #ログインを必須にする。ログインが必要のないページはskip_before_filterを設定する。
  before_filter :require_login

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
end
