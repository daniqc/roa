class LoMetadataSchema < ActiveRecord::Base
	belongs_to :learning_object
	belongs_to :metadata_schema

	attr_accessible :learning_object_id, :metadata_schema_id, :value
end
