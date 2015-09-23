class AddResultToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :result, :text
  end
end
