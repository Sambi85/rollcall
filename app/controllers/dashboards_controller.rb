class DashboardsController < ApplicationController
  def show
    @trackers = Tracker.order(updated_at: :desc)
    @global_abilities = Ability.all
    @global_effects = Effect.where(creature_id: nil)
    @saved_creatures = Creature.where(tracker_id: nil)
    @special_events = SpecialEvent.all

    # @trackers = current_user.trackers.order(updated_at: :desc)
    # @global_abilities = current_user.abilities
    # @global_effects = current_user.effects
    # @saved_creatures = current_user.creatures
    # @special_events = current_user.special_events
  end
end
