class AbilityUsagesController < ApplicationController
  before_action :set_ability_usage, only: %i[ show edit update destroy ]

  # GET /ability_usages or /ability_usages.json
  def index
    @ability_usages = AbilityUsage.all
  end

  # GET /ability_usages/1 or /ability_usages/1.json
  def show
  end

  # GET /ability_usages/new
  def new
    @ability_usage = AbilityUsage.new
  end

  # GET /ability_usages/1/edit
  def edit
  end

  # POST /ability_usages or /ability_usages.json
  def create
    @ability_usage = AbilityUsage.new(ability_usage_params)

    respond_to do |format|
      if @ability_usage.save
        format.html { redirect_to @ability_usage, notice: "Ability usage was successfully created." }
        format.json { render :show, status: :created, location: @ability_usage }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ability_usage.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ability_usages/1 or /ability_usages/1.json
  def update
    respond_to do |format|
      if @ability_usage.update(ability_usage_params)
        format.html { redirect_to @ability_usage, notice: "Ability usage was successfully updated." }
        format.json { render :show, status: :ok, location: @ability_usage }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ability_usage.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ability_usages/1 or /ability_usages/1.json
  def destroy
    @ability_usage.destroy!

    respond_to do |format|
      format.html { redirect_to ability_usages_path, status: :see_other, notice: "Ability usage was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ability_usage
      @ability_usage = AbilityUsage.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def ability_usage_params
      params.expect(ability_usage: [ :tracker_id, :creature_id, :ability_id, :used_at, :round_used, :cooldown_remaining ])
    end
end
