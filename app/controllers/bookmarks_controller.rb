class BookmarksController < ApplicationController
  before_action :authenticate_user!
  before_action :find_apartment, only: [:create]

  def create
    bookmark = @apartment.bookmarks.new(user_id:current_user.id)
    bookmark.save
    flash[:notice] = "Added to bookmark"
    redirect_to apartments_path(@apartment)
  end


  def destroy
  end

  private
  def find_apartment
    @apartment = Apartment.find(params[:apartment_id])
  end
end
