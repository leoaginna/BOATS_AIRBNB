class Boat < ApplicationRecord
  has_many :rentals
  has_many :users, through: :rentals
  validates :name, :description, :price, :address, presence: true
  has_many_attached :photos
end
