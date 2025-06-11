class ContentTagsController < ApplicationController
  def toggle_favorite
    content = Content.find(params[:content_id])
    tag = Tag.find_by(name: params[:tag_name])
    return head :not_found unless content && tag

    content_tag = ContentTag.find_or_initialize_by(content_id: content.id, tag_id: tag.id)

    content_tag.favorite = !content_tag.favorite
    content_tag.save!

    redirect_to content_tags_path(content)
  end
end
