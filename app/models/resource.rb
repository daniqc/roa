class Resource < ActiveRecord::Base
	has_many :resource_files
	belongs_to :learning_object
  attr_accessible :identifier, :learning_object_id, :principal_resource_ref, :resource_type

  def self.create_resource(learning_object, identifier, resource_type, principal_resource_ref)
  	Resource.create(
  		:learning_object_id => learning_object.id,
  		:identifier => identifier,
  		:resource_type => resource_type,
  		:principal_resource_ref => principal_resource_ref
  		)
  	
  end
end
