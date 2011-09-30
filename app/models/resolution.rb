class Resolution < ActiveRecord::Base

  attr_accessible :resolution, :meeting_id, :proposed_by, :seconded_by, :member_id
  belongs_to :meeting
  belongs_to :members
  
end
