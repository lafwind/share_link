class LinksController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @links = @user.links.all
  end

end
