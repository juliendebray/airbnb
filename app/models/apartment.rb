class Apartment < ActiveRecord::Base
  belongs_to :user
  has_many :bookings
  has_many :bookmarks
  validates :address, presence: true
  validates :description, presence: true
  validates :price, presence: true


  has_attached_file :picture,
  styles: {
    medium: "220x220#", thumb: "100x100#" }

  validates_attachment_content_type :picture,
    content_type: /\Aimage\/.*\z/

end
