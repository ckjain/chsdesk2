class CreateMeetingTypes < ActiveRecord::Migration
  def change
    create_table :meeting_types do |t|
      t.string :types

      t.timestamps
    end
  MeetingType.create(:types => "Managing Committee")
  MeetingType.create(:types => "Sub Committee")
  MeetingType.create(:types => "Repair Committee")
  MeetingType.create(:types => "Special General Body")
  MeetingType.create(:types => "Annual General Body")
  MeetingType.create(:types => "Security Committee")
  MeetingType.create(:types => "Cultural Committee")
  MeetingType.create(:types => "Hosue Keeping Committee")
  MeetingType.create(:types => "Security Committee")
  MeetingType.create(:types => "Sports Committee")
  MeetingType.create(:types => "Facility Committee")

  end
end
