class ContentsController < ApplicationController
  def index
    @contents = current_user.contents
  end

  def show
    @content = Content.find(params[:id])
  end
end
