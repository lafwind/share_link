class LinksController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @links = @user.links.all
  end

  def new
    @user = User.find(params[:user_id])
    @link = @user.links.new
  end

  def create
    @user = User.find(params[:user_id])
    @link = @user.links.create(params[:link].permit(:title, :url))

    respond_to do |format|
      if @link.save
        flash[:success] = "Create new link successfully!"
        format.html { redirect_to user_links_path(@user) }
      else
        flash[:error] = "Some error!"
        format.html { render 'new' }
      end
    end
  end

  def edit
    @user = User.find(params[:user_id])
    @link = @user.links.find(params[:id])
  end

  def update
    @user = User.find(params[:user_id])
    @link = @user.links.find(params[:id])
    respond_to do |format|
      if @link.update_attributes(params[:link].permit(:title, :url))
        flash[:success] = "Update successfully!"
        format.html { redirect_to user_links_path(@user) }
      else
        flash[:error] = "Some error here!"
        format.html { render 'edit' }
      end
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @link = @user.links.find(params[:id])
    @link.destroy
    redirect_to user_links_path
  end

end
