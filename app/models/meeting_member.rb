class MeetingMember < ActiveRecord::Base
   attr_accessible :meeting_id,:member_id, :attending_member

  belongs_to :meetings
  belongs_to :members
  
end
