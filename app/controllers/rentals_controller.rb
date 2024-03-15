class RentalsController < ApplicationController
  def index
    @my_rentals = Rental.where("user_id = ?", current_user.id)
    @past_rentals = @my_rentals.select { |rental| rental.end_time < Date.today || rental.state == 'cancelled'}
    @current_rentals = @my_rentals.select { |rental| rental.end_time >= Date.today && rental.state != 'cancelled'}
  end

  def create
    @boat = Boat.find params[:rental][:boat_id]
    @rental = Rental.new rental_params
    @rental.user = current_user
    @rental.boat = @boat
    @rental.state= 'accepted'
    if @rental.start_time.present? && @rental.end_time.present?
      if @rental.start_time > @rental.end_time
        redirect_to boat_path(@boat), status: :see_other, alert: "Start time can't be after End time"
      else
        if @rental.start_time < Date.today || @rental.end_time < Date.today
          redirect_to boat_path(@boat), status: :see_other, alert: "You can't book a boat in the past"
        else
          if @rental.save
            redirect_to rentals_path, status: :see_other
          else
            render "boats/show"
          end
        end
      end
    else
      redirect_to boat_path(@boat), status: :see_other, alert: "You need a Start and End time to book a boat"
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
  def edit
    @current_rental = Rental.find(params[:id])
  end

  def update
    @current_rental = Rental.find(params[:id])
    if @current_rental.update(rental_params)
      redirect_to rentals_path
    else
      render 'boats/show'
    end
  end

  def cancel
    @rental = Rental.find params[:id]
    @rental.update state: 'cancelled'
    redirect_to rentals_path
  end

  private

  def review_params
    params.require(:rental).permit(:review)
  end

  def rental_params
    params.require(:rental).permit(:start_time, :end_time)
  end
end
