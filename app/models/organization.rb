class Organization < ActiveRecord::Base
	has_many :items, :dependent => :destroy
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

	def self.update_title(organization_title_id, organization_title)
		org_title = find(organization_title_id)
		org_title.update_attributes(:title => organization_title)
	end
end
