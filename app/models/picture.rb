class Picture < ApplicationRecord
  belongs_to :topic, optional: true
  belongs_to :comment, optional: true
end