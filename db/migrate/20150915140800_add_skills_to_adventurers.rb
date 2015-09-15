class AddSkillsToAdventurers < ActiveRecord::Migration
  def change
    change_table :adventurers do |t|
      t.text :skills
    end
  end
end
