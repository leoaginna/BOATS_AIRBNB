class BoatsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:show, :index]

  def index
    @boats = Boat.all
  end

  def my_boats
    @my_boats = Boat.where(user_id: current_user.id)
  end

  def show
    @rental = Rental.new
    @boat = Boat.find params[:id]
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
    @boat = Boat.find params[:id]
  end

  def update
    @boat = Boat.find params[:id]
    if @boat.update boat_params
      redirect_to myboats_path, status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def delete_my_boat
    @boat = Boat.find(params[:id])
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
end
