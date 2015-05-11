class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def show
    @links = @user.links.all
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      flash[:success] = "Welcome to the Link You!"
      # redirect_to user_url(@user)
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    if @user != current_user
      redirect_to root_url
    end
  end

  def update
    if @user != current_user
      redirect_to root_url
    else
      if @user.update_attributes(update_user_params)
        #if @user.authenticate(params[:user][:password])
        # change password
        redirect_to current_user
      else
        flash.now[:error] = "Invalid old password!"
        render 'edit'
      end
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
                                  :password_confirmation)
    end

    def update_user_params
      params.require(:user).permit(:password, :password_confirmation)
    end

    def find_user
      @user = User.find(params[:id])
    end
end
