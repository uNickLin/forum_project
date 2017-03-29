class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :user_photo, PhotoImageUploader

  has_many :topics
  has_many :comments

  def is_creator?(topic)
    topic.user == self

  end

end
