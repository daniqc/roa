class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :organization_id
      t.string :identifier
      t.string :title
      t.boolean :isvisible
      t.string :resource_ref_id

      t.timestamps
    end
  end
end
