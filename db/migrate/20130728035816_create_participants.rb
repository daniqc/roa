class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.integer :course_id
      t.integer :role_id
      t.integer :person_id

      t.timestamps
    end
  end
end
