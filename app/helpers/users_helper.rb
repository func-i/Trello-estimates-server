module UsersHelper
  def current_user
    session[:user]
  end
end
