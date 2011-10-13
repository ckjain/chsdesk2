class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.date :meeting_date,      :default => '0000-00-00'
      t.time :meeting_time,      :default => '00:00'
      t.integer :meeting_type_id
      t.string :called_by,        :default => 'Hon. Secretary'
      t.timestamps
    end
  end
end
