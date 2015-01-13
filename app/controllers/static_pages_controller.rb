class StaticPagesController < ApplicationController
  def home
    @users = User.all
    @all_share_links = []

    @users.each do |user|
      user_links = user.links.all
      user_links.each do |link|
        if link.sharing == true
          comments_count = link.comments.count
          @all_share_links << [user, link, comments_count]
        end
      end
    end
  end

  def about
  end
end
