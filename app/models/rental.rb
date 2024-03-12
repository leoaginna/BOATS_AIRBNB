class Rental < ApplicationRecord
  belongs_to :boats
  belongs_to :users
  validates :start_time, :end_time, presence: true
end
