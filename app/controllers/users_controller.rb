class UsersController < ApplicationController
  def my_posts
    @my_posts = current_user.topics.page(params[:page]).per(5)
    @my_comments = current_user.comments.all
  end
end
