class HomesController < ApplicationController
  def top
   if signed_in?
    @post  = current_user.posts.build
    if params[:q] && params[:q].reject { |key, value| value.blank? }.present?
      @q = current_user.feed.ransack(posts_search_params)
      @feed_items = @q.result.page(params[:page]).per(5)
    else
      @q= Post.none.ransack
      @feed_items = current_user.feed.page(params[:page]).per(5)
    end
    @url = root_path
   end
  end
end
