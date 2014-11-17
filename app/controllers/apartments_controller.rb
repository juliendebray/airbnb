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
