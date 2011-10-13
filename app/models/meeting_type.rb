class MeetingType < ActiveRecord::Base
  attr_accessible :types

  has_many :meetings
         
 scope :meetingtype_search, lambda { |search| 
  search = "%#{search}%"
  where('types LIKE ? ', search)
 }
def updated_meeting
       updated_at > 10.minutes.ago
  end
end
