class Organization < ActiveRecord::Base
	has_many :items
	belongs_to :learning_object

	attr_accessible :identifier, :learning_object_id, :structure, :title

	accepts_nested_attributes_for :items, :allow_destroy => true

	def self.create_organization(learning_object, identifier, structure, title)
		Organization.create(
			:learning_object_id => learning_object.id,
			:identifier => identifier,
			:title => title,
			:structure => structure)
	end
end
