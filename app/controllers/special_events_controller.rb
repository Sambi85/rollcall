class SpecialEventsController < ApplicationController
  before_action :set_special_event, only: [ :show, :edit, :update, :destroy ]

  def index
    @special_events = SpecialEvent.all #WIP...
    render json: @special_events
  end

  def show
    render json: @special_event
  end

  def create
    @special_event = SpecialEvent.new(
      name: special_event_params[:name],
      description: special_event_params[:description],
      frequency: special_event_params[:frequency],
      tracker_id: special_event_params[:tracker_id] || nil
    )
    if @special_event.save
      redirect_to @special_event, notice: "Special event created."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @special_event.update(special_event_params)
      redirect_to @special_event, notice: "Special event updated."
    else
      render :edit
    end
  end

  def destroy
    @special_event.destroy
    redirect_to special_events_path, notice: "Special event deleted."
  end

  private

  def set_special_event
    @special_event = SpecialEvent.find(params[:id])
  end

  def special_event_params
    params.require(:special_event).permit(:name, :description, :frequency, :tracker_id)
  end
end
