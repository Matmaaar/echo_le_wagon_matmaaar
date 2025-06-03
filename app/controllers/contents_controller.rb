class ContentsController < ApplicationController
  def index
    @contents = current_user.contents
    @content = Content.new
  end

  def show
    @content = Content.find(params[:id])
    @content.user = current_user
  end
end
