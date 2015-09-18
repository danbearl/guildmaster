class CreateQuestLogs < ActiveRecord::Migration
  def change
    create_table :quest_logs do |t|
      t.integer :adventurer_id
      t.text :body

      t.timestamps null: false
    end
  end
end
