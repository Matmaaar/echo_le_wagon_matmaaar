class ChangeJsonTranscrition < ActiveRecord::Migration[7.1]
  def change
    remove_column :contents, :transcription, :text
    add_column :contents, :transcription, :jsonb
    # sources types => valeur par default = video
    change_column_default :contents, :source_type, :string, default: 'video'
  end
end
