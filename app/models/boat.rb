class Boat < ApplicationRecord
  include PgSearch::Model #for search
  has_many :rentals
  belongs_to :user
  validates :name, :description, :price, :address, presence: true
  has_many_attached :photos

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  pg_search_scope :search_by_address,
    against: [ :address ],
    using: {
    tsearch: { prefix: true }
  }
end
