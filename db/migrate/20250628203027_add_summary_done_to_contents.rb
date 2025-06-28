class AddSummaryDoneToContents < ActiveRecord::Migration[7.1]
  def change
    add_column :contents, :summary_done, :boolean
  end
end
