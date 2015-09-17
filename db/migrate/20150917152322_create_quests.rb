class CreateQuests < ActiveRecord::Migration
  def change
    create_table :quests do |t|
      t.string :title
      t.text :steps
      t.integer :guildhall_id, default: 0
      t.text :rewards
      t.date :deadline
      t.boolean :complete, default: false

      t.timestamps null: false
    end
  end
end
