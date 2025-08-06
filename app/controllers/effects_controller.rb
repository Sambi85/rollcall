class EffectsController < ApplicationController
  before_action :set_effect, only: [ :show, :update, :destroy ]

  def index
    @effects = Effect.where(creature_id: nil)
    render json: @effects
  end

  def show
    render json: @effect
  end

  def create
    @effect = Effect.new(effect_params)

    if @effect.save
      render json: @effect, status: :created
    else
      render json: { errors: @effect.errors.full_messages }, status: :unprocessable_entity
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

  def set_effect
    @effect = Effect.find(params[:id])
  end

  def effect_params
    params.require(:effect).permit(:name, :description, :duration, :status_type)
  end
end
