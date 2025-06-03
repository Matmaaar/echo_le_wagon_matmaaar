class RenameContentForNote < ActiveRecord::Migration[7.1]
  def change
    rename_column :notes, :content, :description
  end
end
