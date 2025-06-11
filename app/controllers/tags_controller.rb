class TagsController < ApplicationController
  def index
    @content = Content.find(params[:content_id])
    @tags = @content.tags
  end
end
