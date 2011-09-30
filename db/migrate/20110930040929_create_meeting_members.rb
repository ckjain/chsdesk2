class CreateMeetingMembers < ActiveRecord::Migration
  def change
    create_table :meeting_members do |t|
      t.integer :meeting_id
      t.integer :member_id
      t.integer :attending_member

      t.timestamps
    end
  end
end
