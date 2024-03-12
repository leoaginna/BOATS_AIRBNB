class Boat < ApplicationRecord
  has_many :rentals
  belongs_to :user
  validates :name, :description, :price, :address, presence: true
  has_many_attached :photos
end
