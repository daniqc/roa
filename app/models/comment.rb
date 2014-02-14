class Comment < ActiveRecord::Base
	has_ancestry
	belongs_to :learning_object
	belongs_to :person
	
	attr_accessible :comment, :like, :learning_object_id, :parent_id, :person_id
end
