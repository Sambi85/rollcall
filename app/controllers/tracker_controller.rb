# app/controllers/tracker_controller.rb
class TrackerController < ApplicationController
  before_action :set_tracker, only: [:next_round, :get_initiative_order, :get_dead_combatants]

  def next_round
    @tracker.next_round
    render json: { round: @tracker.round }, status: :ok
  end

  def get_initiative_order
    order = @tracker.creatures.order(initiative_roll: :desc).pluck(:name)
    render json: { initiative_order: order }
  end

  def get_dead_combatants
    dead_combatants = @tracker.creatures.where(dead: true).pluck(:name)
    render json: { dead_combatants: dead_combatants }
  end

  private

  def set_tracker
    @tracker = Tracker.find(params[:id])
  end
end
