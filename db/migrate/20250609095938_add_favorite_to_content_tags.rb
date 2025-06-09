class AddFavoriteToContentTags < ActiveRecord::Migration[7.1]
  def change
    add_column :content_tags, :favorite, :boolean, default: false, null: false
  end
end
