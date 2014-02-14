class CreateMetadataSchemas < ActiveRecord::Migration
  def change
    create_table :metadata_schemas do |t|
      t.string :name

      t.timestamps
    end
  end
end
