class AddUserIdToProfile < ActiveRecord::Migration
  def change
    change_table :profiles do |t|
      t.integer :user_id
    end
  end
end
