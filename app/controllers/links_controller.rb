class LinksController < ApplicationController

  before_action :find_user
  before_action :find_link, only: [:upvote, :downvote]

  def index
    if @user != current_user
      # @links = []
      # all_links = @user.links.all

      # all_links.each do |link|
      #   if link.sharing == true
      #     @links << link
      #   end
      # end
      @links = @user.links.where(sharing: true).order("created_at DESC").paginate(page: params[:page])
    else
      #@links = @user.links.all
      @links = @user.links.order("created_at DESC").paginate(page: params[:page])
    end
  end

  def show
    @link = @user.links.find(params[:id])
    if @user != current_user && @link.sharing == false
      redirect_to login_path
    else
      @comments = []
      @link.comments.all.each do |comment|
        # debugger
        user = User.find(comment.user_id)
        @comments << [user, comment.content]
      end
    end
  end

  def new
    if @user != current_user
      redirect_to root_url
    else
      @link = @user.links.new
    end
  end

  def create
    if @user != current_user
      redirect_to root_url
    else
      @link = @user.links.create(link_params)

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
    if @user != current_user
      redirect_to root_url
    else
      @link = @user.links.find(params[:id])
    end
  end

  def update
    if @user != current_user
      redirect_to root_url
    else
      @link = @user.links.find(params[:id])
      respond_to do |format|
        if @link.update_attributes(link_params)
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
    if @user != current_user
      redirect_to root_url
    else
      @link = @user.links.find(params[:id])
      @link.destroy
      redirect_to user_links_path
    end
  end

  def share
    if @user != current_user
      redirect_to root_url
    else
      @link = @user.links.find(params[:id])
      @link.update_attribute(:sharing, true)
      # redirect_to user_links_path, notice: "Link had been shared!"
      flash[:success] = "Link had been shared"
      redirect_to user_links_path
    end
  end

  def unshare
    if @user != current_user
      redirect_to root_url
    else
      @link = @user.links.find(params[:id])
      @link.update_attribute(:sharing, false)
      # redirect_to user_links_path, notice: "Unshared the link now!"
      flash[:error] = "Unshared the link now"
      redirect_to user_links_path
    end
  end

  def upvote
    @link.upvote_by current_user
    @link.update_attribute(:like_count, @link.get_upvotes.size)
    redirect_to :back
  end

  def downvote
    @link.downvote_by current_user
    @link.update_attribute(:like_count, @link.get_upvotes.size)
    redirect_to :back
  end

  private

  def link_params
    params.require(:link).permit(:title, :description, :url)
  end

  def find_user
    @user = User.find(params[:user_id])
  end

  def find_link
    find_user
    @link = @user.links.find(params[:id])
  end

end
