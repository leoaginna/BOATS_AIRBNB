class Boat < ApplicationRecord
  has_many :rentals
  belongs_to :user
  validates :name, :description, :price, :address, presence: true
  has_many_attached :photos

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
