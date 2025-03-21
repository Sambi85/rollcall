class Creature < ApplicationRecord
  belongs_to :tracker, optional: true

  validates :name, presence: true 

  after_initialize :set_defaults

  def set_defaults
    self.dead = false if self.dead.nil?
  end

  def kill
    update(dead: true)
  end
end
