class UsersController < ApplicationController
  def my_posts
    @my_posts = current_user.topics.all

  end
end
