class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :display_name
      t.string :about

      t.timestamps null: false
    end
  end
end
