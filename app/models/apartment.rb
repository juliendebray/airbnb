class Apartment < ActiveRecord::Base
  belongs_to :user
  has_many :bookings
  validates :address, presence: true
  validates :description, presence: true
  validates :price, presence: true
end
