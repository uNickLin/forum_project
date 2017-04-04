class Topic < ApplicationRecord
	validates_presence_of :title, :content
	delegate :name, :to => :category, :prefix => true, :allow_nil => true
	delegate :email, :to => :user, :prefix => true, :allow_nil => true

	belongs_to :category
	belongs_to :user

	has_many :comments, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  has_many :pictures, dependent: :destroy

  def group_by_comments_users(topic)
    comments_users = []
    topic.comments.each do |j|
      comments_users << j.user.nickname
    end

    return comments_users.uniq
  end

  def find_like(user)
    Like.where( :topic_id => self.id, :user_id => user.id ).first
  end

  def is_liked_by(user)
    find_like(user).present?
  end



end
