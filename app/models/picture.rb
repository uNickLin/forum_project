class Picture < ApplicationRecord
  mount_uploader :image, PhotoImageUploader

  belongs_to :topic, optional: true
  belongs_to :comment, optional: true
end