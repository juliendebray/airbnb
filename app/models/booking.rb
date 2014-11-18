class Booking < ActiveRecord::Base
  belongs_to :apartment
  belongs_to :user
  validate :booking_is_available

  private

  def booking_is_available
    unless booking_available?
      errors.add(:base, 'Not available')
    end
  end

  def booking_available?
    bookings = Booking.where(apartment_id: self.apartment_id)
    bookings_overlaps = bookings.select do |b|
      self.end_date > b.start_date && self.start_date < b.end_date
    end

    bookings_overlaps.count == 0
  end
end
