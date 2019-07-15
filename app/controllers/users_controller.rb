  class UsersController < ApplicationController
    # load_and_authorize_resource
    skip_before_action :session_lookup, only: [:new, :create, :login, :validate_user]

  # after_action :monitor_signin_and_sign_up, only: [:validate_user]
  # before_action :monitor_signin_and_sign_up, only: [:logout]
  include Marticle
  def index
    #cookies[:name] = {value: "Hello SriRam", expires: 1.minute}
    # @users = User.all
    @users = User.paginate(page: params[:page], per_page: 4)
  end

  def new
    @user = User.new
    @user.build_image # builder concept
  end

  def create
    @user = User.new(user_params)
    if @user.save
      SendEmailMailer.very_email(@user).deliver_now
      #flash[:notice] = "Try to to login now"
      flash[:notice] = "Check your email to get admin access post login"
      redirect_to login_path
    else
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    authorize! :edit, @user
    if @user.update(user_params)
      flash[:notice] = "Object got updated successfully"
      redirect_to users_path
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
  end

  # def login
  # end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "Object got deleted successfully"
    redirect_to users_path
  end

  def validate_user
    @user = User.authenitcate(params[:email], params[:password])
    if @user
      # session lookup is a helper to watch this session for every request defined in application_controller
      session[:user_id] = @user.id
      flash[:notice] = "Successfully logged in"
      redirect_to users_path
    else
      flash[:notice] = "Either username or password not matching"
      render :login
    end
  end
  def logout
    session[:user_id] =  nil
    flash[:notice] = "Logged out Successfully"
    redirect_to login_path
  end
  # def monitor_signin_and_sign_up
  #   File.open("#{Rails.root}/public/user_history.txt", "a+") {|foo|
  #     find_user = User.find_by_id(session[:user_id])
  #     method = (params[:action] == "validate_user" ? ("signin"):("logout"))
  #     foo.puts("User with id #{find_user.id} and email #{find_user.email} #{method} at #{Time.now}")
  #   }
  # end
  # def create_article
  #
  # end
  def make_admin
    user = User.find(params[:id])
    user.admin = true
    user.save
    redirect_to users_path
  end
  def user_params
    # params is nothing but a strong parameter and gets generated from HashWithIndifferentAccess
    params.require(:user).permit!
  end
end
