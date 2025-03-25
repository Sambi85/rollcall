class Tracker < ApplicationRecord
  has_many :creatures

  serialize :turn_order, coder: YAML

  after_initialize :set_defaults

  def set_defaults
    self.turn_order ||= []
  end

  def sort_turn_order
    self.turn_order.sort_by! { |creature_id| Creature.find(creature_id).initiative }.reverse!
    save!
  end

  def mark_active_turn
    turn_order.rotate!
    save!
  end
end
