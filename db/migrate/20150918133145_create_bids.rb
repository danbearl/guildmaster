class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.integer :guildhall_id
      t.integer :quest_id
      t.integer :amount

      t.timestamps null: false
    end
  end
end
