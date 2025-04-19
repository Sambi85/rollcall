class EffectsController < ApplicationController
  before_action :set_creature
  before_action :set_effect, only: [:destroy]

  def index
    @effects = @creature.effects
  end

  def create
    @effect = @creature.effects.build(effect_params)

    if @effect.save
      redirect_to creature_path(@creature), notice: 'Effect added!'
    else
      render :new
    end
  end

  def destroy
    @effect.destroy
    redirect_to creature_path(@creature), notice: 'Effect removed.'
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
