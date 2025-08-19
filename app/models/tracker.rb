class Tracker < ApplicationRecord
  has_many :special_events
  has_many :creatures, dependent: :destroy
  has_many :ability_usages, dependent: :destroy

  serialize :turn_order, coder: YAML

  after_initialize :set_defaults

  def set_defaults
    self.turn_order ||= []
    self.round ||= 1
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

  def advance_turn
    return if turn_order.empty?

    turn_order.rotate!
    # increment round only if we've cycled back to the first creature
    self.round += 1 if turn_order.first == first_before_rotate
    save!
    trigger_special_events
  end

  def first_before_rotate
    @last_first ||= turn_order.first
  end

  def current_turn
    Creature.find_by(id: turn_order.first)
  end

  def turn_order_entities
    turn_order.map { |id| Creature.find_by(id: id) || SpecialEvent.find_by(id: id) }.compact
  end

  def trigger_special_events
    special_events.each do |event|
      puts "Special Event Triggered: #{event.name}" if self.round % event.frequency == 0
    end
  end

  def next_round
    self.mark_active_turn
    self.round += 1
    save!
    trigger_special_events
  end

  def current_turn_name
    current_turn&.name || "Unknown"
  end
end
