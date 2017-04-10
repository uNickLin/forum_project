class Topic < ApplicationRecord
	validates_presence_of :title, :content
	delegate :name, :to => :category, :prefix => true, :allow_nil => true
	delegate :email, :to => :user, :prefix => true, :allow_nil => true

	belongs_to :category, optional: true
	belongs_to :user, optional: true

	has_many :comments, dependent: :destroy

  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  has_many :pictures, dependent: :destroy
  accepts_nested_attributes_for :pictures

  has_many :collections
  has_many :collected_users, through: :collections, source: :user

  def group_by_comments_users
    comments_users = []
    self.comments.each do |j|
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

  def find_collection(user)
    Collection.where( :topic_id => self.id, :user_id => user.id ).first
  end

  def is_collected_by(user)
    find_collection(user).present?
  end


end
