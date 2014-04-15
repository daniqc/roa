class Content < ActiveRecord::Base
	has_ancestry

	belongs_to :course
	has_many :learning_materials
	has_many :learning_objects, :through => :learning_materials

	attr_accessible :course_id, :hours, :in_hours, :name, :number, :out_hours, :type, :parent_id

	def self.contents(contents_ids)
		where(:id => contents_ids)
    end
end
