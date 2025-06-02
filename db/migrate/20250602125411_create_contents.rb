class CreateContents < ActiveRecord::Migration[7.1]
  def change
    create_table :contents do |t|
      t.text :transcription
      t.string :source_type
      t.string :url
      t.string :thumbnail
      t.string :name
      t.integer :duration
      t.string :language
      t.text :summary
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
