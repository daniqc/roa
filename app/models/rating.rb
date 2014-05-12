class Rating < ActiveRecord::Base
	belongs_to :learning_object
	belongs_to :person

	attr_accessible :comment, :evaluation, :learning_object_id, :person_id
	validates :evaluation, presence: true
end
