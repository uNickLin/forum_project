class ApiV1::TopicsController < ApiController

	def index
		@topics = Topic.all
    # render json: @topics.to_json

  end

  def show
    @topic = Topic.find_by(id: params[:id]) #find(id)若找不到值會錯誤，但find_by可以自訂錯誤訊息
    if @topic
      # render json: @topic.to_json
    else
      render json: {message: 'fail!'}, status: 400
    end
  end

  def create
    @topic = Topic.new(title: params[:title], content: params[:content])
    if @topic.save
      render json: {message: 'ok!'}
    else
      render json: {message: 'fail!'}, status: 400
    end
  end

  def update
    @topic = Topic.find_by(id: params[:id])
    if @topic.update(title: params[:title], content: params[:content])
      render json: {message: 'ok!'}
    else
      render json: {message: 'fail!'}, status: 400
    end
  end

  # private

  # def topic_params
  #   params.require(:topic).permit(:title, :content)
  # end
  
end
