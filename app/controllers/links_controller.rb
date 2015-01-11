class LinksController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    if @user != current_user
      @links = []
      all_links = @user.links.all

      all_links.each do |link|
        if link.sharing == true
          @links << link
        end
      end
    else
      @links = @user.links.all
    end
  end

  def new
    @user = User.find(params[:user_id])
    if @user != current_user
      redirect_to root_url
    else
      @link = @user.links.new
    end
  end

  def create
    @user = User.find(params[:user_id])
    if @user != current_user
      redirect_to root_url
    else
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
  end

  def edit
    @user = User.find(params[:user_id])
    if @user != current_user
      redirect_to root_url
    else
      @link = @user.links.find(params[:id])
    end
  end

  def update
    @user = User.find(params[:user_id])
    if @user != current_user
      redirect_to root_url
    else
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
  end

  def destroy
    @user = User.find(params[:user_id])
    if @user != current_user
      redirect_to root_url
    else
      @link = @user.links.find(params[:id])
      @link.destroy
      redirect_to user_links_path
    end
  end

  def share
    @user = User.find(params[:user_id])
    if @user != current_user
      redirect_to root_url
    else
      @link = @user.links.find(params[:id])
      @link.update_attribute(:sharing, true)
      redirect_to user_links_path, notice: "Link had been shared!"
    end
  end

  def unshare
    @user = User.find(params[:user_id])
    if @user != current_user
      redirect_to root_url
    else
      @link = @user.links.find(params[:id])
      @link.update_attribute(:sharing, false)
      redirect_to user_links_path, notice: "Unshared the link now!"
    end
  end

end
