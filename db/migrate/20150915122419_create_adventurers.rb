class CreateAdventurers < ActiveRecord::Migration
  def change
    create_table :adventurers do |t|
      t.text :name
      t.integer :guildhall_id

      t.timestamps null: false
    end
  end
end
