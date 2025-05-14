class CreatureAbilitiesController < ApplicationController
  before_action :set_creature_ability, only: %i[ show edit update destroy ]

  # GET /creature_abilities or /creature_abilities.json
  def index
    @creature_abilities = CreatureAbility.all
    render json: @creature_abilities
  end

  # GET /creature_abilities/1 or /creature_abilities/1.json
  def show
    render json: @creature_ability
  end

  # GET /creature_abilities/new
  def new
    @creature_ability = CreatureAbility.new
    render json: @creature_ability
  end

  # GET /creature_abilities/1/edit
  def edit
  end

  # POST /creature_abilities or /creature_abilities.json
  def create
    @creature_ability = CreatureAbility.new(creature_ability_params)

    respond_to do |format|
      if @creature_ability.save
        format.html { redirect_to @creature_ability, notice: "Creature ability was successfully created." }
        format.json { render :show, status: :created, location: @creature_ability }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @creature_ability.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /creature_abilities/1 or /creature_abilities/1.json
  def update
    respond_to do |format|
      if @creature_ability.update(creature_ability_params)
        format.html { redirect_to @creature_ability, notice: "Creature ability was successfully updated." }
        format.json { render :show, status: :ok, location: @creature_ability }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @creature_ability.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /creature_abilities/1 or /creature_abilities/1.json
  def destroy
    @creature_ability.destroy!

    respond_to do |format|
      format.html { redirect_to creature_abilities_path, status: :see_other, notice: "Creature ability was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    def set_creature_ability
      @creature_ability = CreatureAbility.find(params.expect(:id))
    end

    def creature_ability_params
      params.expect(creature_ability: [ :creature_id, :ability_id, :usage_limit, :cooldown_rounds, :notes ])
    end
end
