class CreatureEffectsController < ApplicationController
  before_action :set_creature
  before_action :set_effect, only: [ :update, :destroy ]

  def index
    render json: @creature.effects
  end

  def create
    @effect = @creature.effects.build(effect_params)

    if @effect.save
      render json: @effect, status: :created
    else
      render json: @effect.errors, status: :unprocessable_entity
    end
  end

  def update
    if @effect.update(effect_params)
      render json: @effect
    else
      render json: @effect.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @effect.destroy
    head :no_content
  end

  private

  def set_creature
    @creature = Creature.find(params[:creature_id])
  end

  def set_effect
    @effect = @creature.effects.find(params[:id])
  end

  def effect_params
    params.require(:effect).permit(:name, :description, :duration, :status_type)
  end
end
