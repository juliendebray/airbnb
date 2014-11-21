class BookmarksController < ApplicationController
  before_action :authenticate_user!
  before_action :find_apartment, only: [:create, :destroy]

  def create
    bookmark = @apartment.bookmarks.new(user_id:current_user.id)
    bookmark.save
    flash[:notice] = "Added to bookmark"
    redirect_to apartments_path(@apartment)
  end


  def destroy
    bookmark = Bookmark.find(params[:id])
    bookmark.destroy
    redirect_to user_path(current_user)
  end

  private
  def find_apartment
    @apartment = Apartment.find(params[:apartment_id])
  end
end
