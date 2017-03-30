class TopicsController < ApplicationController

	before_action :authenticate_user!, except: [:index, :about_us]
	before_action :find_topic, except: [:index, :new, :create, :about_us]

	def index
		category = Category.find_by(name: params[:category]) if params[:category]

		@topics = if params[:keyword]
                Topic.where( [ "title like ?", "%#{params[:keyword]}%" ] ).page(params[:page]).per(10)
             	elsif category
              	category.topics.order("created_at DESC").page(params[:page]).per(10)
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
		@comment = Comment.new
		@comments = Comment.order("created_at desc")

	end

	def edit

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
		@comment = @topic.comments.new(comment_params)
    @comment.user = current_user
    if @comment.save
      @topic.latest_comment_time = @topic.comments.last
      @topic.comments_num = @topic.comments.count
      @topic.save
      redirect_to topic_path(@topic)

    end

	end

  def del_comment
    if params[:m]
      @comment = @topic.comments.find(params[:m])
      @comment.destroy

      redirect_to topic_path(@topic)
    elsif params[:c]
      @comment = Comment.find(params[:c])
      @comment.destroy

      redirect_to my_posts_user_path(current_user)
    end

  end



	private

	def topic_params
		params.require(:topic).permit(:title, :content, :category_id, :user_id, :latest_comment_time, :comments_num)

	end

	def comment_params
		params.require(:comment).permit(:message, :topic_id, :user_id)
	end

	def find_topic
		@topic = Topic.find(params[:id])

	end

end
