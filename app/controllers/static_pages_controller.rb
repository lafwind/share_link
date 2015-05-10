class StaticPagesController < ApplicationController
  def home
    @users = User.all
    # @all_share_links = []

    @links = Link.where(user_id: @users, sharing: true).order("created_at DESC").paginate(page: params[:page], per_page: 10)
    # @users.each do |user|
    #   user_links = user.links.all
    #   user_links.each do |link|
    #     if link.sharing == true
    #       comments_count = link.comments.count
    #       @all_share_links << [user, link, comments_count]
    #     end
    #   end
    # end
    #
    # @all_share_links.paginate(page: params[:page], per_page: 2)
  end

  def about
  end
end
