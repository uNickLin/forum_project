class Collection < ApplicationRecord
  belongs_to :topics
  belongs_to :users
end