class RentalsController < ApplicationController
  def index
    @rentalss = Rental.all
  end

  def create
    @rental = Rental.new rental_params
    @rental.user = current_user
    @rental.boat = @boat
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
