class TrackersController < ApplicationController
  before_action :set_tracker, only: [:next_round, :get_initiative_order, :get_dead_combatants]

  #POST trackers/:id/next_round
  def next_round
    @tracker.next_round
    render json: { round: @tracker.round }, status: :ok
  end

  #GET trackers/:id/get_initiative_order
  def get_initiative_order
    order = @tracker.creatures.order(initiative: :desc).pluck(:name)
    render json: { initiative_order: order }
  end

  #GET trackers/:id/get_dead_combatants
  def get_dead_combatants
    dead_combatants = @tracker.creatures.where(dead: true).pluck(:name)
    render json: { dead_combatants: dead_combatants }
  end

  private

  def set_tracker
    @tracker = Tracker.find(params[:id])
  end
end
