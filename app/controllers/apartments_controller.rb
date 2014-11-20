class ApartmentsController < ApplicationController
  def new
    @user = current_user
    if @user
      @apartment = @user.apartments.new
    else
      redirect_to root_path
    end
  end

  def create
    @user = current_user
    @apartment = @user.apartments.new(apartment_params)
    if @apartment.save
      redirect_to apartment_path(@apartment)
    else
      render :new
    end
  end

  def index #TODO : use a single SQL request with outer join /
    if params[:search]
      if params[:search][:start_date] && params[:search][:end_date] && params[:search][:address]
        @address = params[:search][:address]
        @start_date = params[:search][:start_date]
        @end_date = params[:search][:end_date]

        all_apartments_with_address = Apartment.where(address: @address)
        @apartments = all_apartments_with_address.select do |apartment|
          bookings = apartment.bookings.where('start_date < :end_date AND end_date > :start_date',
            end_date: Date.parse(@end_date),
            start_date: Date.parse(@start_date)
          )
          bookings.count == 0
        end
      elsif params[:search][:address]
        @address = params[:search][:address]
        @apartments = Apartment.where(address: @address)
      end
    else
      @apartments = Apartment.all
    end
    apartments_with_coordinates = @apartments.where.not(latitude: nil, longitude: nil)
    @markers = Gmaps4rails.build_markers(apartments_with_coordinates) do |apartment, marker|
      marker.lat apartment.latitude
      marker.lng apartment.longitude
    end
  end

  def destroy
  end

  def show
    @apartment = Apartment.find(params[:id])
    @booking = @apartment.bookings.new
  end

 private

  def apartment_params
    params.require(:apartment).permit(:address, :description, :price, :picture)
  end

end
