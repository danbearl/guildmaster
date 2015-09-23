class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :contract_id
      t.integer :adventurer_id
      t.date :ends_at

      t.timestamps null: false
    end
  end
end
