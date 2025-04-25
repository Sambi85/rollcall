class Creature < ApplicationRecord
  belongs_to :tracker, optional: true
  has_many :effects, dependent: :destroy

  validates :name, presence: true

  after_initialize :set_defaults

  def set_defaults
    self.dead = false if self.dead.nil?
    self.current_hp ||= 0
    self.max_hp ||= 0
    self.temp_hp ||= 0
  end

  def mark_dead
    update!(dead: true)
  end

  def mark_alive
    update!(dead: false)
  end

  def down(amount = 1)
    if temp_hp > 0
      if amount <= temp_hp
        self.temp_hp -= amount
      else
        remaining = amount - temp_hp
        self.temp_hp = 0
        self.current_hp -= remaining
      end
    else
      self.current_hp -= amount
    end

    self.current_hp = 0 if current_hp < 0
    mark_dead if current_hp <= 0
    save
  end

  def up(amount = 1)
    return if dead

    self.current_hp += amount
    self.current_hp = max_hp if current_hp > max_hp
    save
  end

  def restore
    self.current_hp = max_hp
    self.temp_hp = 0
    mark_alive
    save
  end
end
