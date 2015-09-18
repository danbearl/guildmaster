class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.integer :guildhall_id
      t.integer :quest_id
      t.integer :amount

      t.timestamps null: false
    end
  end
end
