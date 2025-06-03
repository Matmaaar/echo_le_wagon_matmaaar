class ContentsController < ApplicationController
  def index
    @contents = current_user.contents
    @content = Content.new
  end
end
