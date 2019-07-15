class Api::UsersController < ApplicationController
  def index
    @user = User.all
    respond_to do | format |
      format.json {render json: @user}
    end
  end
  def create
    @user = User.new(user_params)
    respond_to do | format |
      if @user.save
        format.json { render json: @user, message: "Saved Successfully" }
      else
        format.json { render json: @user.errors, message: "No saved" }
      end
    end
  end

  def update
    @user = User.find(params[:id])
    respond_to do | format |
      if @user.update(user_params)
        format.json { render json: @user, message: "Updated Successfully" }
      else
        format.json { render json: @user.errors, message: "No updated" }
      end
    end
  end

  def destroy
    @user = User.find(params[:id])
    respond_to do | format |
      @user.delete
      format.json { render json:  {message: "Deleted!!!"} }
    end
  end

  def show
    @user = User.find(params[:id])
    respond_to do | format |
      format.json {render json: @user}
      format.xml {render xml: eval(@user.to_json)}
    end
  end

  def user_params
    params.require(:user).permit!
  end
end
