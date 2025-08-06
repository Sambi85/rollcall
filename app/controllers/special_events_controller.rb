class SpecialEventsController < ApplicationController
  before_action :set_special_event, only: [ :show, :update, :destroy ]

  def index
    @special_events = SpecialEvent.all
    render json: @special_events
  end

  def show
    render json: @special_event
  end

  def create
    @special_event = SpecialEvent.new(special_event_params)

    if @special_event.save
      render json: @special_event, status: :created
    else
      render json: @special_event.errors, status: :unprocessable_entity
    end
  end

  def update
    if @special_event.update(special_event_params)
      render json: @special_event
    else
      render json: @special_event.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @special_event.destroy
    head :no_content  # returns a 204 No Content response
  end

  private

  def set_special_event
    @special_event = SpecialEvent.find(params[:id])
  end

  def special_event_params
    params.require(:special_event).permit(:name, :description, :frequency, :tracker_id)
  end
end
