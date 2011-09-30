class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.date :meeting_date
      t.time :meeting_time
      t.integer :meeting_type_id

      t.timestamps
    end
  end
end
