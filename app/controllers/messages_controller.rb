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
    respond_to do |format|
      format.turbo_stream { head :ok }
      format.html { redirect_to messages_path }
    end
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
