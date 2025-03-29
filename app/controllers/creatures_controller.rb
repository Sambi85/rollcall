class CreaturesController < ApplicationController
  before_action :set_tracker
  before_action :set_creature, only: [:mark_dead, :restore_combatant]

  #POST curl -X POST http://localhost:3000/trackers/:id/creatures
  def add_combatant
    creature = Creature.create(creature_params)
    @tracker.add_combatant(creature)
    render json: { message: "#{creature.name} added to initiative order!" }, status: :created
  end

  #PUT
  def mark_dead
    @tracker.mark_dead(@creature)
    render json: { message: "#{@creature.name} marked as dead" }, status: :ok
  end

  #PUT
  def restore_combatant
    @tracker.restore_combatant(@creature)
    render json: { message: "#{@creature.name} restored to initiative order" }, status: :ok
  end

  private

  def set_tracker
    @tracker = Tracker.find(params[:tracker_id])
  end

  def set_creature
    @creature = Creature.find(params[:id])
  end

  def creature_params
    params.require(:creature).permit(:name, :role, :initiative_roll, :hp)
  end
end
