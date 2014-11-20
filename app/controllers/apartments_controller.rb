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

  def index #TODO : use a single SQL request with outer join / factorise with method
    if params[:search][:address].size > 0
      if params[:search][:start_date].size + params[:search][:end_date].size > 1
        @address = params[:search][:address]
        @start_date = params[:search][:start_date]
        @end_date = params[:search][:end_date]

        all_apartments_with_address = Apartment.near(@address, 20)
        @apartments = all_apartments_with_address.select do |apartment|
          bookings = apartment.bookings.where('start_date < :end_date AND end_date > :start_date',
            end_date: Date.parse(@end_date),
            start_date: Date.parse(@start_date)
          )
          bookings.count == 0
        end
      else
        @address = params[:search][:address]
        @apartments = Apartment.near(@address, 20)
      end
    else
      @apartments = Apartment.all
    end
    if @apartments.size != 0
      apartments_with_coordinates = @apartments.where.not(latitude: nil, longitude: nil)
      @markers = Gmaps4rails.build_markers(apartments_with_coordinates) do |apartment, marker|
        marker.lat apartment.latitude
        marker.lng apartment.longitude
      end
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
