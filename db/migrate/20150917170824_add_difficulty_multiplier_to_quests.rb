class AddDifficultyMultiplierToQuests < ActiveRecord::Migration
  def change
    add_column :quests, :difficulty_multiplier, :integer
  end
end
