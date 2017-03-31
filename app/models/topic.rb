class Topic < ApplicationRecord
	validates_presence_of :title, :content
	delegate :name, :to => :category, :prefix => true, :allow_nil => true
	delegate :email, :to => :user, :prefix => true, :allow_nil => true

	belongs_to :category
	belongs_to :user

	has_many :comments, dependent: :destroy

  def group_by_comments_users(topic)
    comments_users = []
    topic.comments.each do |j|
      comments_users << j.user.nickname
    end

    return comments_users.uniq
  end
end
