class Rental < ApplicationRecord
  belongs_to :boats
  belongs_to :users
end
