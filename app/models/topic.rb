class Topic < ApplicationRecord
	validates_presence_of :title, :content
	delegate :name, :to => :category, :prefix => true, :allow_nil => true
	
	belongs_to :category
end
