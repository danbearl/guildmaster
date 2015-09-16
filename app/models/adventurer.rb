class Adventurer < ActiveRecord::Base
  belongs_to :guildhall
  serialize :skills

  after_initialize :init_adventurer

  def init_adventurer
    self.name ||= Faker::Name.first_name + " " + Faker::Name.last_name
    unless self.skills
      self.skills = { }
      3.times do
        skill = Adventurer.skill_list.sample
        self.skills.has_key?(skill) ? self.skills[skill] += 1 : self.skills[skill] = 1
      end
    end
  end

  def level
    self.skills.values.inject {|sum, x| sum + x }
  end

  def salary
    (level / 4).floor + 1
  end

  private
  def self.skill_list
    [:melee, :black_magic, :white_magic, :swimming, :climbing, :archery, :stealth, :lock_picking, :knowledge, :common_sense]
  end

end


