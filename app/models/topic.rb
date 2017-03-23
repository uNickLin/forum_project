class Topic < ApplicationRecord
	validates_presence_of :title, :content
	delegate :name, :to => :category, :prefix => true, :allow_nil => true
	delegate :email, :to => :user, :prefix => true, :allow_nil => true
	
	belongs_to :category
	belongs_to :user
end
