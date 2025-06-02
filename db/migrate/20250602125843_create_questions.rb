class CreateQuestions < ActiveRecord::Migration[7.1]
  def change
    create_table :questions do |t|
      t.string :statement
      t.string :answer_true
      t.string :answer_1
      t.string :answer_2
      t.string :answer_3
      t.text :explanation
      t.references :content, null: false, foreign_key: true

      t.timestamps
    end
  end
end
