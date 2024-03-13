class RentalsController < ApplicationController
  def index
    @rentalss = Rental.all
    @my_rentals = Rental.where(user_id: current_user.id)
    @past_rentals = @my_rentals.select { |rental| rental.end_time < Date.today }
  end

  def create
    @boat = Boat.find params[:rental][:boat_id]
    @rental = Rental.new rental_params
    @rental.user = current_user
    @rental.boat = @boat
    if @rental.save
      redirect_to rentals_path, status: :see_other
    else
      render "boats/show"
    end
  end
  # not to be used until everywthing else is working -simon
  # def create_review
  #   @rental = Rental.find params[:id]
  #   @rental.review = review_params[:review]
  #   if @rental.save
  #     redirect_to @rental, status: :see_others
  #   else
  #     render rental_path
  #   end
  # end

  def update
    @rental = Rental.find params[:id]
    if @rental.update(rental_params)
      redirect_to @rental, status: :see_others
    else
      render rental_path
    end
  end

  def cancel
    @rental = Rental.find params[:id]
    @rental.available = false
  end

  private

  def review_params
    params.require(:rental).permit(:review)
  end

  def rental_params
    params.require(:rental).permit(:start_time, :end_time)
  end
end
