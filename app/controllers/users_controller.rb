class UsersController < ApplicationController
  before_action :authenticate_user!
  def show
    current_user
    @bookings = current_user.bookings
    @apartments = current_user.apartments
    @bookmarks = current_user.bookmarks
  end
end
