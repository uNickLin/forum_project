class Comment < ApplicationRecord
  validates_presence_of :message

	belongs_to :user
	belongs_to :topic

  has_many :pictures, dependent: :destroy
  accepts_nested_attributes_for :pictures
end
