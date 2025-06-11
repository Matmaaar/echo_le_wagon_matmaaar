class AddValidatedToQuestion < ActiveRecord::Migration[7.1]
  def change
    add_column :questions, :validated, :boolean, default: false, null: false
  end
end
