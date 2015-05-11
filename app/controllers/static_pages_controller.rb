class StaticPagesController < ApplicationController
  def home
    @ranked_by = [
      { name: "hottest" },
      { name: "newest" },
      { name: "popularoty" }
    ]

    @users = User.all

    if params[:ranked_by].blank? || params[:ranked_by] == "hottest"
      @links = Link.where(user_id: @users, sharing: true).order("like_count DESC").order("created_at DESC").paginate(page: params[:page], per_page: 10)
    else
      case params[:ranked_by]
      when "newest"
        @links = Link.where(user_id: @users, sharing: true).order("created_at DESC").paginate(page: params[:page], per_page: 10)
      when "popularoty"
        @links = Link.where(user_id: @users, sharing: true).order("votes DESC").order("created_at DESC").paginate(page: params[:page], per_page: 10)
      end
    end
  end

  def about
  end
end
