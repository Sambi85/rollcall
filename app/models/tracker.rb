class Tracker < ApplicationRecord
  serialize :turn_order, Array

  has_many :creatures

  after_initialize :set_defaults

  def set_defaults
    self.round ||= 1
    self.turn_order ||= []
  end

  def sort_turn_order
    self.turn_order.sort_by! { |creature_id| Creature.find(creature_id).initiative }.reverse!
  end

  def mark_active_turn
    turn_order.rotate!
  end
end
