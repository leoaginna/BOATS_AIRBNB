class BoatsController < ApplicationController
  def index
    @boats = Boat.all
  end

  def show
    @boat = Boat.find params[:id]
  end

  def new
    @boat = Boat.new
  end

  def create
    @boat = Boat.new boat_params
    if @boat.save
      redirect_to @boat, status: :see_others
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
      redirect_to @boat, status: :see_others
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def delete
    @boat = Boat.find params[:id]
    @boat.destroy
    redirect_to boats_path, status: :see_others
  end

  private

  def boat_params
    params.require(:boat).permit(:name, :description, :price, :address, :available)
  end
end
