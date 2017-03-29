class Comment < ApplicationRecord
  validates_presence_of :message

	belongs_to :user
	belongs_to :topic, dependent: :destroy
end
