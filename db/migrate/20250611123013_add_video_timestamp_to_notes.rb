class AddVideoTimestampToNotes < ActiveRecord::Migration[7.1]
  def change
    add_column :notes, :video_timestamp, :string
  end
end
