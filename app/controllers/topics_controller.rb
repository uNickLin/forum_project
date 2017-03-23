class TopicsController < ApplicationController

	before_action :authenticate_user!, except: [:index, :new, :create]
	before_action :find_topic, except: [:index, :new, :create]

	def index
		@topics = Topic.order("created_at DESC").page(params[:page]).per(10)
		
	end

	def new
		@topic = Topic.new
		
	end

	def create
		@topic = Topic.new(topic_params)
		@topic.user = current_user
		if @topic.save		
			redirect_to topics_path
		else
			render :new
		end

	end

	def show
		
	end

	def edit
		
	end

	def update
		if @topic.update(topic_params)
			redirect_to topic_path(@topic)
		else
			render :edit
		end
		
	end

	def destroy
		@topic.destroy

		redirect_to topics_path
		
	end



	private

	def topic_params
		params.require(:topic).permit(:title, :content, :category_id, :user_id)
		
	end

	def find_topic
		@topic = Topic.find(params[:id])

	end

end
