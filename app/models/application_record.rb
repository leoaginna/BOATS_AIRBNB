class ApplicationRecord < ActiveRecord::Base
  include PgSearch::Model #for search
  primary_abstract_class
end
