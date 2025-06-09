class MessagesController < ApplicationController

  def index
    @content = Content.find(params[:content_id])
    @messages = @content.messages
    @message = Message.new # for form
  end


  def create
    @content = Content.find(params[:content_id])
    @messages = @content.messages # needed in case of validation error
    @message = Message.new(message_params)
    @message.content = @content
    if @message.save
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.append(:message, partial: "messages/message",
            locals: { message: @message })
        end
        format.html { redirect_to messages_path }
      end
    else
     render :index, status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:user_question)
  end
end
