class UsersController < ApplicationController
  def index
    @users= User.all.limit(15)
    respond_to do |format|
      format.html { render 'main/index' }
      format.js {}
    end
  end

  def new

  end

  def show

  end

  def create
    user = User.new(user_params)
    if user.save
      flash[:notice] = 'New user successfully created'
      redirect_to '/'
    else
      redirect_to '/users/new'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
