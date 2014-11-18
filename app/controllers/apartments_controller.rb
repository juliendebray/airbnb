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

  def index #TODO : use a single SQL request with outer join
    if params[:search]
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
    else
      @apartments = Apartment.all
    end
  end

  def destroy
  end

  def show
    @apartment = Apartment.find(params[:id])
  end

 private

  def apartment_params
    params.require(:apartment).permit(:address, :description, :price, :picture)
  end

end
