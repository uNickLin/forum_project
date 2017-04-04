class Comment < ApplicationRecord
  validates_presence_of :message

	belongs_to :user
	belongs_to :topic

  has_many :pictures, dependent: :destroy
end
