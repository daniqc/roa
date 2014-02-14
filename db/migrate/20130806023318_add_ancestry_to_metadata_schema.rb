class AddAncestryToMetadataSchema < ActiveRecord::Migration
  def self.up
    add_column :metadata_schemas, :ancestry, :string
    add_index :metadata_schemas, :ancestry
  end

  def self.down
  	remove_index :metadata_schemas, :ancestry
  	remove_column :metadata_schemas, :ancestry  	
  end
end
