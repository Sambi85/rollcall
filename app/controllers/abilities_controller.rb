class AbilitiesController < ApplicationController
  before_action :set_ability, only: %i[show update destroy]

  def index
    @abilities = Ability.all
    render json: @abilities
  end

  def show
    render json: @ability
  end

  def create
    @ability = Ability.new(ability_params)
    if @ability.save
      render json: @ability, status: :created
    else
      render json: @ability.errors, status: :unprocessable_entity
    end
  end

  def update
    if @ability.update(ability_params)
      render json: @ability
    else
      render json: @ability.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @ability.destroy!
    head :no_content
  end

  private

  def set_ability
    @ability = Ability.find(params[:id])
  end

  def ability_params
    params.require(:ability).permit(:name, :description, :usage_type, :default_usage_limit, :default_cooldown)
  end
end
