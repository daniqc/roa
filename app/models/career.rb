class Career < ActiveRecord::Base
	has_many :courses
	attr_accessible :id, :name
end
