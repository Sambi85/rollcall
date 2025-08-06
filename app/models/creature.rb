class Creature < ApplicationRecord
  belongs_to :tracker, optional: true
  has_many :effects, dependent: :destroy
  has_many :creature_abilities, dependent: :destroy
  has_many :abilities, through: :creature_abilities
  has_many :ability_usages, dependent: :destroy

  validates :name, presence: true

  after_initialize :set_defaults

  def set_defaults
    self.dead = false if self.dead.nil?
    self.current_hp ||= 0
    self.max_hp ||= 0
    self.temp_hp ||= 0
    self.death_saves_successes ||= 0
    self.death_saves_failures ||= 0
  end

  def mark_dead
    update!(dead: true)
  end

  def mark_alive
    update!(dead: false)
  end

  def down(damage_amount = 1)
    if temp_hp > 0
      if damage_amount <= temp_hp
        self.temp_hp -= damage_amount
      else
        remaining = damage_amount - temp_hp
        self.temp_hp = 0
        self.current_hp -= remaining
      end
    else
      self.current_hp -= damage_amount
    end

    self.current_hp = 0 if current_hp < 0
    mark_dead if current_hp <= 0
    save
  end

  def up(heal_amount = 1)
    return if dead

    self.current_hp += heal_amount
    self.current_hp = max_hp if current_hp > max_hp
    save
  end

  def restore
    self.current_hp = max_hp
    self.temp_hp = 0
    mark_alive
    save
  end

  def reset_death_saves
    update!(death_saves_successes: 0, death_saves_failures: 0)
  end

  def add_death_save(success:)
    if success
      increment!(:death_saves_successes)
      mark_alive if death_saves_successes >= 3
    else
      increment!(:death_saves_failures)
      mark_dead if death_saves_failures >= 3
    end
  end
end
