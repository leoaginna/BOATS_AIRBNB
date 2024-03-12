class Rental < ApplicationRecord
  belongs_to :boat
  belongs_to :user
end
