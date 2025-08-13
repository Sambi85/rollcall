class Tracker < ApplicationRecord
  has_many :special_events
  has_many :creatures, dependent: :destroy
  has_many :ability_usages, dependent: :destroy

  serialize :turn_order, coder: YAML

  after_initialize :set_defaults

  def set_defaults
    self.turn_order ||= []
  end

  def add_combatant(creature)
    creature.tracker_id = self.id
    self.turn_order << creature.id
    self.sort_turn_order
    save!
  end

  def sort_turn_order
    self.turn_order.sort_by! { |creature_id|
                                Creature.find(creature_id).initiative
                              }.reverse!
    save!
  end

  def mark_active_turn
    turn_order.rotate!
    save!
  end

  def trigger_special_events
    special_events.each do |event|
      if self.round % event.frequency == 0
        puts "Special Event Trigged: #{event.name}"
      end
    end
  end

  def next_round
    self.mark_active_turn
    self.round += 1
    save!
    trigger_special_events
  end

  def current_turn_name
    return "N/A" if turn_order.empty?
    creature = Creature.find_by(id: turn_order.first)
    creature&.name || "Unknown"
  end
end
