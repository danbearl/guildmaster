class Quest < ActiveRecord::Base
  serialize :steps
  serialize :rewards
  has_one :contract
  has_many :bids

  after_initialize :init_quest

  def lowest_bid
    unless self.bids.empty?
      self.bids.sort { |a, b| a.amount <=> b.amount }.first.amount
    else
      0
    end
  end

  private
  def init_quest
    unless self.id
      self.difficulty_multiplier = rand(1..10)
      self.steps = Quest.create_quest_steps
      self.steps.each do |step|
        step[:difficulty] = rand(1..5) * self.difficulty_multiplier
      end
      self.guildhall_id = 0
      self.rewards = Quest.generate_rewards
      self.deadline = Date.today + steps.count * 2
      self.title = steps.last[:title]
    end
  end

  def self.create_quest_steps
    steps = []
    rand(1..5).times do
      steps.push(BASIC_STEPS.sample)
    end
    steps.push(FINAL_STEPS.sample)
    steps
  end

  def self.generate_rewards
    []
  end
  BASIC_STEPS = [
    {title: "To Cross A River",
     description: "A river blocked my path",
     skills: {
      swimming: "I braved the mighty current and crossed to the other side.",
      knowledge: "I built a bridge to the other side.",
      black_magic: "I cast a spell of freezing and walked across the ice.",
      },
     action_failure: "The current proved too strong, and I was forced to turn back.",
    },
    {title: "To Defeat A Black Knight",
     description: "A black knight challenged me.",
     skills: {
      melee: "I defeated him in single combat.",
      archery: "As he approached, I shot him with an arrow.",
      black_magic: "I cast a fireball spell, and he ran away in fear.",
      stealth: "I managed to distract him and sneak past."
      },
     action_failure: "His skill proved too much for me to overcome.",
    },
    {title: "To Overcome An Asp's Bite",
     description: "While I crossed the wilderness, an asp poisoned me.",
     skills: {
      white_magic: "I cast a spell of healing and quickly recovered.",
      knowledge: "I foraged for healing herbs and was able to neutralize the poison.",
      },
     action_failure: "The poison made me too weak to continue.",
    },
    {title: "To Scale A Cliff",
     description: "A cliff blocked my path",
     skills: {
      climbing: "I scaled the cliff with ease.",
      },
     action_failure: "The rock face proved too treacherous for my skills.",
    },
  ]
  FINAL_STEPS = [
    {title: "To Slay a Dragon",
     description: "A fearsome dragon menaces a town!",
     skills: {
      melee: "I fought mightily and defeated the dragon in close combat!",
      black_magic: "I cast a spell to put the dragon to sleep, then slit its throat!",
      archery: "I shot the dragon out of the sky with one well-placed arrow!"
      },
     action_failure: "The dragon proved too powerful for me to defeat.",
    },
    {title: "To Retrieve A Relic From An Ancient Tomb",
     description: "A powerful relic lost in an ancient tomb awaits discovery.",
     skills: {
      lock_picking: "I skillfully disabled the locks and traps and claimed the prize!",
      knowledge: "I deciphered the clues in an ancient language to solve the riddle of the tomb!",
      stealth: "I deftly snuck past the tombs traps and guards to steal the treasure!"
      },
     action_failure: "The tomb's mysteries proved too much for me to handle.",
    },
  ]

end
