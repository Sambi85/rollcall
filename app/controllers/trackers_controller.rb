class TrackersController < ApplicationController
  before_action :set_tracker, only: [ :resume, :next_round, :get_initiative_order, :get_dead_combatants ]

  def resume
    @turn_order = @tracker.turn_order_entities
  end

  # PUT trackers/:id/next_round
  def next_round
    @tracker.next_round
    render json: { round: @tracker.round }, status: :ok
  end

  # PUT /trackers/:id/next_turn
  def next_turn
    @tracker.advance_turn

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to resume_tracker_path(@tracker) }
      format.json { render json: { round: @tracker.round, current_turn: @tracker.current_turn_name } }
    end
  end

  # GET trackers/:id/get_initiative_order
  def get_initiative_order
    order = @tracker.creatures.order(initiative: :desc).pluck(:name)
    render json: { initiative_order: order }
  end

  # GET trackers/:id/get_dead_combatants
  def get_dead_combatants
    dead_combatants = @tracker.creatures.where(dead: true).pluck(:name)
    render json: { dead_combatants: dead_combatants }
  end

  private

  def set_tracker
    @tracker = Tracker.find(params[:id])
  end
end
