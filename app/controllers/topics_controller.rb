class TopicsController < ApplicationController

	before_action :authenticate_user!, except: [:index, :about_us]
	before_action :find_topic, except: [:index, :new, :create, :about_us]

  # PERMIT_PARAMS = [:comments_sort, :x  , :c ]

	def index
		category = Category.find_by(name: params[:category]) if params[:category]

		@topics = if params[:keyword] #根據keyword篩選
                Topic.where( [ "title like ?", "%#{params[:keyword]}%" ] ).page(params[:page]).per(10)

             	elsif category #根據類別下拉選單篩選
              	category.topics.order("created_at DESC").page(params[:page]).per(10)

##
  # params?.in?PERMIT_PARAMS
##

              elsif params[:comments_sort] #根據使用者點擊留言數的左右箭頭排列ACS/DESC
                if params[:comments_sort] == 'comments_up'
                  Topic.order("comments_num ASC").page(params[:page]).per(10)
                elsif params[:comments_sort] == 'comments_down'
                  Topic.order("comments_num DESC").page(params[:page]).per(10)
                end

              elsif params[:post_sort] #根據使用者點擊建立日期的左右箭頭排列ACS/DESC
                if params[:post_sort] == 'post_up'
                  Topic.order("created_at ASC").page(params[:page]).per(10)
                elsif params[:post_sort] == 'post_down'
                  Topic.order("created_at DESC").page(params[:page]).per(10)
                end

              elsif params[:latest_comment_sort] #根據使用者點擊最新留言的左右箭頭排列ACS/DESC
                if params[:latest_comment_sort] == 'latest_comment_up'
                  Topic.order("latest_comment_time ASC").page(params[:page]).per(10)
                elsif params[:latest_comment_sort] == 'latest_comment_down'
                  Topic.order("latest_comment_time DESC").page(params[:page]).per(10)
                end

              else
                Topic.order("created_at DESC").page(params[:page]).per(10)
              end

	end

	def new
		@topic = Topic.new
    @picture = @topic.pictures.new

	end

	def create
		@topic = Topic.new(topic_params)
		@topic.user = current_user

		if @topic.save
			redirect_to topics_path
			flash[:notice] = "新增成功！"
		else
			render :new
		end

	end

	def show
    @comments = @topic.comments.order("created_at asc")

    if params[:edit_comment_in_topic]
      @comment = @topic.comments.find(params[:edit_comment_in_topic])

      # respond_to do |format|
      #   format.js
      #   format.html {render :show}
      # end

    else
		  @comment = Comment.new
      @picture = @comment.pictures.new

    end

	end

	def edit
    # @picture = @topic.pictures.find(params[:image])
    @picture = @topic.pictures.new

	end

	def update
		if @topic.update(topic_params)
			redirect_to topic_path(@topic)
			flash[:warning] = "更新成功！"
		else
			render :edit
		end

	end

	def destroy
		@topic.destroy

    respond_to do |format|
      # remote: true
      format.js #destroy.js.erb
      format.html {redirect_to topics_path}
    end

		# redirect_to topics_path
		# flash[:alert] = "刪除成功！"
	end

	def comments
		 if params[:edit_comment_in_topic]
      @comment = @topic.comments.find(params[:edit_comment_in_topic])
      @comment.update(comment_params)

      # redirect_to topic_path(@topic)
      respond_to do |format|
        format.js
        format.html {redirect_to topic_path(@topic)}
      end

    else
      @comment = @topic.comments.new(comment_params)
      @comment.user = current_user
      if @comment.save
        @topic.latest_comment_time = @topic.comments.last
        @topic.comments_num = @topic.comments.count
        @topic.save

        respond_to do |format|
          format.js
          format.html {redirect_to topic_path(@topic)}
        end

      else
        render :show

      end
    end


	end

  def edit_comment

  end

  def del_comment
    if params[:del_comment_in_topic]
      @comment = current_user.comments.find(params[:del_comment_in_topic])
      @comment.destroy

      respond_to do |format|
        format.js #執行 del_comment.js.erb
        format.html {redirect_to topic_path(@topic)}
      end

    elsif params[:del_comment_in_my_posts]
      @comment = current_user.comments.find(params[:del_comment_in_my_posts])
      @comment.destroy

      redirect_to my_posts_users_path
    end

  end


  def like
    unless @topic.is_liked_by(current_user)
      Like.create( topic: @topic, user: current_user )
    end

    respond_to do |format|
      format.js
      format.html { redirect_to topic_path(@topic) }
    end

  end

  def dislike
    like = @topic.find_like(current_user)
    like.destroy

    respond_to do |format|
      format.js {render :like}
      format.html { redirect_to topic_path(@topic) }
    end

  end

  def add_collection
    unless @topic.is_collected_by(current_user)
      Collection.create( topic_id: @topic.id, user_id: current_user.id )

    end

    respond_to do |format|
      format.js
      format.html { redirect_to topic_path(@topic) }
    end

  end

  def remove_collection
    collection = @topic.find_collection(current_user)
    collection.destroy

    respond_to do |format|
      format.js {render :add_collection}
      format.html { redirect_to topic_path(@topic) }
    end

  end


	private

	def topic_params
		params.require(:topic).permit(:title, :content, :category_id, :user_id, :latest_comment_time, :comments_num, pictures_attributes: [:image])

	end

	def comment_params
		params.require(:comment).permit(:message, :topic_id, :user_id, pictures_attributes: [:image])
	end

	def find_topic
		@topic = Topic.find(params[:id])

	end

end
