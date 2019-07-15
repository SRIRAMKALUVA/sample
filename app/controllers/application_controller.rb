class ApplicationController < ActionController::Base

  # to disable csrf token check when request format is json
  protect_from_forgery with: :exception , unless: Proc.new {|c| c.request.format.json? or c.request.format.xml?}
  # if the request is json format , session_lookup will skipped
  before_action :session_lookup, unless: Proc.new {|c| c.request.format.json? or c.request.format.xml?}

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end


  def session_lookup
    # if session is not available , redirec tthe request to login page
    if session[:user_id].nil?
      redirect_to login_path
    end
  end
  def current_user
    User.find(session[:user_id])
  end
end
