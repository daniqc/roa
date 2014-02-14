class AddPersonIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :person_id, :integer
  end
end
