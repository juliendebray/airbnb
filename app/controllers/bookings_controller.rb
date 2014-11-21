class BookingsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_apartment, only: :create

  def create
    @booking = current_user.bookings.new(booking_params)
    @booking.apartment = @apartment
    if @booking.save
      redirect_to apartment_booking_path(@apartment, @booking)
      # redirect_to @apartment, notice: 'Booking was successfully created.'
    else
      redirect_to @apartment, alert: 'Apartment is not available'
    end
  end

  def show
  end

  private
  def booking_params
    params.require(:booking).permit(:start_date, :end_date)
  end

  def find_apartment
    @apartment = Apartment.find(params[:apartment_id])
  end
end
