class AddTempFlagToAdventurers < ActiveRecord::Migration
  def change
    change_table :adventurers do |t|
      t.boolean :temp, default: true
    end
  end
end
