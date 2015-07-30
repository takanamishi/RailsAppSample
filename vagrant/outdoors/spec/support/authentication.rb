module Authentication
  def login email, password = 'login'
    user.update_attribute :password, password
    page.driver.post login_path, {user_name: user.email, password: password}
  end
end