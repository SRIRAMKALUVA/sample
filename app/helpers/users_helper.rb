module UsersHelper
  def rname
   User.find(session[:user_id]).name
  end
end
