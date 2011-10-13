class MeetingMember < ActiveRecord::Base
   attr_accessible :meeting_id,:member_id, :committee_member_id

  belongs_to :meeting
  belongs_to :member
  belongs_to :committee_member
 
  scope :meetingmember_search, lambda { |search| 
  search = "%#{search}%"
  where('committee_member_id LIKE ? ', search)
 }

end
