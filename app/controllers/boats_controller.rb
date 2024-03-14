class BoatsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :index]
  before_action :set_boat, only: %i[ show edit update suspend delete_my_boat]

  def index
    @boats = Boat.where(available: true)
    @markers = @boats.geocoded.map do |boat|
      {
        lat: boat.latitude,
        lng: boat.longitude,
        info_window_html: render_to_string(partial: "info_window", locals: {boat: boat})
        # marker_html: render_to_string(partial: "marker")
      }
    end
  end

  def my_boats
    @my_boats = Boat.where(user_id: current_user.id)
  end

  def show
    @rental = Rental.new
  end

  def new
    @boat = Boat.new
  end

  def create
    @boat = Boat.new boat_params
    @boat.user = current_user
    if @boat.save
      redirect_to :myboats, status: :see_other
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @boat.update(boat_params[:photos] == [""] ? boat_params.except(:photos) : boat_params)
      redirect_to myboats_path, status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def suspend
    if @boat.available == true || @boat.available.nil?
      @boat.update available: false
      redirect_to :myboats, status: :see_other
    else
      @boat.update available: true
      redirect_to :myboats, status: :see_other
    end
  end

  def delete_my_boat
    if @boat.rentals.empty?
      @boat.destroy
      redirect_to myboats_path, status: :see_other, notice: "Boat successfully deleted."
    else
      redirect_to myboats_path, status: :see_other, alert: "Cannot delete boat with rentals pending"
    end
  end


  private

  def boat_params
    params.require(:boat).permit(:name, :description, :price, :address, :available, :available_from, :available_until, photos: [])
  end

  def set_boat
    @boat = Boat.find(params[:id])
  end
end
