class Creature < ApplicationRecord
  belongs_to :tracker, optional: true
  has_many :effects, dependent: :destroy

  validates :name, presence: true

  after_initialize :set_defaults

  def set_defaults
    self.dead = false if self.dead.nil?
  end

  def mark_dead
    update!(dead: true)
  end

  def mark_alive
    update!(dead: false)
  end
end
