class CreateLoMetadataSchemas < ActiveRecord::Migration
  def change
    create_table :lo_metadata_schemas do |t|
      t.integer :metadata_schema_id
      t.integer :learning_object_id
      t.string :value

      t.timestamps
    end
  end
end
