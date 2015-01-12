class CommentsController < ApplicationController

  def new
    @user = User.find(params[:user_id])
    @link = @user.links.find(params[:id])
    @comment = @link.comments.new
  end

  def create
    @user = User.find(params[:user_id])
    @link = @user.links.find(params[:link_id])
    @comment = @link.comments.create(params[:comment].permit(:content))
    @comment.user_id = current_user.id

    if @comment.save
      flash[:success] = "Comment successfully!"
      redirect_to user_link_path(@user, @link)
    else
      flash[:error] = "Some errors!"
      redirect_to user_link_path(@user, @link)
    end
  end

end
