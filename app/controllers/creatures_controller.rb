class CreaturesController < ApplicationController
  before_action :set_tracker
  before_action :set_creature, only: [:mark_dead, :mark_alive]

  #POST /trackers/:id/creatures
  def add_combatant
    creature = Creature.create(creature_params)
    @tracker.add_combatant(creature)
    render json: { message: "#{creature.name} added to initiative order!" }, status: :created
  end

  #PUT /trackers/:id/creatures/:id/mark_dead
  def mark_dead
    if @creature.nil?
      render json: { error: "Creature not found, cannot mark dead" }, status: :not_found
      return
    end

    @creature.mark_dead
    render json: { message: "#{@creature.name} marked as dead" }, status: :ok
  end

  #PUT
  def mark_alive
    @creature.mark_alive
    render json: { message: "#{@creature.name} restored to initiative order" }, status: :ok
  end

  private

  def set_tracker
    @tracker = Tracker.find(params[:tracker_id])
  end

  def set_creature
    @creature = Creature.find(params[:creature_id])
  end

  def creature_params
    params.require(:creature).permit(:name, :role, :initiative_roll, :hp)
  end
end
