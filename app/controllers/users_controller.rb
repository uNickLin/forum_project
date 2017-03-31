class UsersController < ApplicationController
  def my_posts
    @my_posts = current_user.topics.page(params[:page]).per(5)
    @my_comments = current_user.comments.order("created_at desc")
  end

  def del_my_post
    @topic = Topic.find(params[:id])
    @topic.destroy

    redirect_to my_posts_users_path

  end

  def my_collection

  end


end
