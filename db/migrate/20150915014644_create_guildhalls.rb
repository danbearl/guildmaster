class CreateGuildhalls < ActiveRecord::Migration
  def change
    create_table :guildhalls do |t|
      t.text :name
      t.integer :gold
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
