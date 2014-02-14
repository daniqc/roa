class ResourceFile < ActiveRecord::Base
	belongs_to :resource
  attr_accessible :name, :resource_id

  def self.create_resource_file(resource,file_href)
	ResourceFile.create(
		:resource_id => resource.id,
		:name => file_href)  	
  end
end
