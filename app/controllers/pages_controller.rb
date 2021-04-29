class PagesController < ApplicationController
  def home
    if @current_user.present?
      @post = @current_user.posts.build 
      @feed_items = @current_user.feed.paginate(page: params[:page])
    end
  end
end
