class Agenda < ActiveRecord::Base
   
  attr_accessible :agenda, :meeting_id, :resolution, :seconded_by,:proposed_by

  belongs_to :meeting
  
scope :agenda_search, lambda { |search| 
  search = "%#{search}%"
  where('agenda LIKE ? OR resolution LIKE ?',  search,  search)
 }

 def updated_agenda
       updated_at > 10.minutes.ago
  end
end
