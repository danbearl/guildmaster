class Adventurer < ActiveRecord::Base
  belongs_to :guildhall
  serialize :skills

  after_initialize :init_adventurer

  def level
    self.skills.values.inject {|sum, x| sum + x }
  end

  def salary
    (level / 4).floor + 1
  end

  def advance
    salary * 4
  end

  def go_on_quest(quest)
    quest_log = { success: true, body: "" }
    quest.steps.each do |step|
      quest_log[:body] += step[:description] + "\n"
      skill = determine_best_skill(step)
      if(attempt_step(step, skill))
        quest_log[:body] += step[:skills][skill] + "\n"
      else
        quest_log[:body] += step[:action_failure] + "\n"
        quest_log[:success] = false
        break
      end
    end

    return quest_log
  end

  private
  def self.skill_list
    [:melee, :black_magic, :white_magic, :swimming, :climbing, :archery, :stealth, :lock_picking, :knowledge, :common_sense]
  end

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

  def map_range (s, min1, max1, min2, max2)
    (min2 + (s - min1) * (max2 - min2) / (max1 - min1)).round(2)
  end

  def calc_prob(skill, difficulty)
    spread = skill.to_f - difficulty.to_f

    0.5 + map_range(spread, -50.0, 49.0, -2, 2)
  end

  def attempt_step(step, skill)

    if rand(1..100) < calc_prob(self.skills[skill], step[:difficulty]) * 100
      true
    else
      false
    end

  end

  def determine_best_skill(step)
    relevant_skills = {}

    step[:skills].each_key do |skill|
      if(self.skills.has_key?(skill))
        relevant_skills[skill] = self.skills[skill]
      end
    end

    best_skill = ""
    highest_level = 0

    relevant_skills.each do |skill, level|
      if level > highest_level then best_skill = skill end
    end

    if(best_skill == "") then best_skill = step[:skills].keys.first end

    best_skill
  end

end


