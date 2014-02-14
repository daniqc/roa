module MetadataSchemasHelper
	def nested_metadata_schema(metadata_schemas)
    	metadata_schemas.map do |metadata_schema, sub_metadata_schemas|
      		render(metadata_schema) + nested_metadata_schema(sub_metadata_schemas)
    	end.join.html_safe
  	end
end
