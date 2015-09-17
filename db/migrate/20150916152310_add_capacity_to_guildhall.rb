class AddCapacityToGuildhall < ActiveRecord::Migration
  def change
    add_column :guildhalls, :capacity, :integer
  end
end
