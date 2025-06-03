class ContentsController < ApplicationController
  def index
    @contents = current_user.contents
    @content = Content.new
  end

  def show
    @content = Content.find(params[:id])
    @questions = @content.questions.shuffle
  end
end
