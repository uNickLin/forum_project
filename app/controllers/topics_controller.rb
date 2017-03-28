class TopicsController < ApplicationController

	before_action :authenticate_user!, except: [:index, :new, :create]
	before_action :find_topic, except: [:index, :new, :create]

	def index
		category = Category.find_by(name: params[:category]) if params[:category]

		@topics = if params[:keyword]
                Topic.where( [ "title like ?", "%#{params[:keyword]}%" ] ).page(params[:page]).per(10)
             	elsif category
              	category.topics.order("created_at DESC").page(params[:page]).per(10)
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
		@comments = Comment.all

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

	private

	def topic_params
		params.require(:topic).permit(:title, :content, :category_id, :user_id, :latest_comment, :comments_num)

	end

	def comment_params
		params.require(:comment).permit(:message, :topic_id, :user_id)
	end

	def find_topic
		@topic = Topic.find(params[:id])

	end

end
