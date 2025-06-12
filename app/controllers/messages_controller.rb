class MessagesController < ApplicationController

  def index
    @content = Content.find(params[:content_id])
    @messages = @content.messages
    @message = Message.new # for form
  end


  def create
  @content = Content.find(params[:content_id])
  @message = Message.new(message_params)
  @message.content = @content

    if @message.save
          head :ok
    else
      @messages = @content.messages
      render :index, status: :unprocessable_entity
    end

  end

  private

  def message_params
    params.require(:message).permit(:user_question)
  end

end
