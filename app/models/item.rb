class Item < ActiveRecord::Base
	belongs_to :organization

	attr_accessible :identifier, :isvisible, :organization_id, :resource_ref_id, :title, :type

	def self.create_item(organization_id, title, resource_ref_id)
		Item.create(
			:organization_id => organization_id,
			:title => title,
			:resource_ref_id => resource_ref_id
			)
	end

	def get_resource_url(learning_object, file_ref)
		# resource_reference = Item.find(self.id).resource_ref_id
		#file_ref = Resource.where(:learning_object_id => learning_object.id, :identifier => resource_reference).first.principal_resource_ref
		# file_ref = Item.find(self.id).resource_ref_id
		"/system/learning_objects/"+learning_object.id.to_s+"/"+file_ref
	end

	
end
