class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.string :week_day
      t.string :start
      t.string :finish

      t.timestamps
    end
  end
end
