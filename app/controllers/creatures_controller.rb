class CreaturesController < ApplicationController
  before_action :set_tracker, except: [ :index ]
  before_action :set_creature, only: [
    :mark_dead, :mark_alive,
    :receive_damage, :heal,
    :reset_death_saves, :add_death_save,
    :update_health
  ]


  # GET /creatures
  def index
    if params[:tracker_id]
      @tracker = Tracker.find(params[:tracker_id])
      @creatures = @tracker.creatures
    else
      @creatures = Creature.all # Top-level route, all creatures
    end
  end

  # POST /trackers/:tracker_id/creatures
  def create
    creature = Creature.create!(
      name: creature_params["name"],
      role: creature_params["role"],
      initiative: creature_params["initiative"],
      tracker_id: @tracker.id
    )
    @tracker.add_combatant(creature)
    render json: { message: "#{creature.name} added to initiative order!" }, status: :created
  end

  # PUT /trackers/:tracker_id/creatures/:creature_id/mark_dead
  def mark_dead
    if @creature.nil?
      render json: { error: "Creature not found, cannot mark dead" }, status: :not_found
      return
    end

    @creature.mark_dead
    render json: { message: "#{@creature.name} marked as dead" }, status: :ok
  end

  # PUT /trackers/:tracker_id/creatures/:creature_id/mark_alive
  def mark_alive
    @creature.mark_alive
    render json: { message: "#{@creature.name} restored to initiative order" }, status: :ok
  end

  # PUT /trackers/:tracker_id/creatures/:creature_id/receive_damage
  def receive_damage
    damage_amount = params[:amount].to_i
    if damage_amount <= 0
      render json: { error: "Damage must be greater than 0" }, status: :bad_request
      return
    end
    @creature.down(damage_amount)
    render json: { message: "#{@creature.name} took #{damage_amount} damage" }, status: :ok
  end

  # PUT /trackers/:tracker_id/creatures/:creature_id/heal
  def heal
    heal_amount = params[:amount].to_i
    if heal_amount <= 0
      render json: { error: "Healing amount must be greater than 0" }, status: :bad_request
      return
    end

    @creature.up(heal_amount)
    render json: { message: "#{@creature.name} healed for #{heal_amount} HP" }, status: :ok
  end

  # PUT /trackers/:tracker_id/creatures/:creature_id/reset_death_saves
  def reset_death_saves
    @creature.reset_death_saves
    render json: {
      message: "Death saves have been reset.",
      creature: @creature
    }, status: :ok
  end

  # PUT trackers/:tracker_id/creatures/:creature_id/add_death_save
  def add_death_save
    if params[:success].nil?
      render json: { error: "Missing parameter: success" }, status: :unprocessable_entity
      return
    end

    success = ActiveModel::Type::Boolean.new.cast(params[:success])
    @creature.add_death_save(success: success)

    render json: {
      message: "Death save recorded.",
      creature: @creature
    }, status: :ok
  end

  # GET /trackers/:tracker_id/creatures/:creature_id/hp_controls
  def hp_controls
    @tracker = Tracker.find(params[:tracker_id])
    @creature = Creature.find(params[:creature_id])
    render partial: "trackers/hp_controls", locals: { tracker: @tracker, creature: @creature }
  end

  # PUT /trackers/:tracker_id/creatures/:id/update_health
  def update_health
    health_params = params.permit(:hp, :temp_hp, :max_hp).to_h.compact_blank

    if health_params.any?
      @creature.update!(health_params)

      respond_to do |format|
        format.turbo_stream do
          render partial: "hp_controls", locals: { creature: @creature, tracker: @tracker }
        end
        format.json { render json: { creature: @creature }, status: :ok }
      end
    else
      respond_to do |format|
        format.turbo_stream { head :unprocessable_entity }
        format.json { render json: { error: "No valid health params provided" }, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_tracker
    @tracker = Tracker.find(params[:tracker_id])
  end

  def set_creature
    @creature = Creature.find(params[:creature_id])
  end

  def creature_params
    params.require(:creature).permit(:name, :role, :initiative)
  end
end
