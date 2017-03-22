class TopicsController < ApplicationController

	def index
		@topics = Topic.all
		
	end

	def new
		@topic = Topic.new
		
	end

	def create
		@topic = Topic.new(topic_params)
		@topic.save
		
		redirect_to topics_path

	end

	def show
		@topic = Topic.find(params[:id])
		
	end

	def edit
		@topic = Topic.find(params[:id])
		
	end

	def update
		@topic = Topic.find(params[:id])
		@topic.update(topic_params)

		redirect_to topic_path(@topic)
		
	end

	def destroy
		@topic = Topic.find(params[:id])
		@topic.destroy

		redirect_to topics_path
		
	end



	private

	def topic_params
		params.require(:topic).permit(:title, :content)
		
	end

end
