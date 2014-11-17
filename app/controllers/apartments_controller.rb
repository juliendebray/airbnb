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

  def index
    @apartments = Apartment.where(address: params[:search][:address])
    @apartements.reject do |apartment|
      apartment.bookings.where('start_date < ? OR end_date > ?',
        Date.parse(params[:start_date]), Date.parse(params[:end_date]))
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
