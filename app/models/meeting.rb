class Meeting < ActiveRecord::Base
   
  attr_accessible :meeting_date, :meeting_type_id, :meeting_time,:called_by
  
  belongs_to :meeting_type
  has_many :meeting_members
  has_many :agendas
  default_scope :order => 'meeting_date DESC'

  scope :agendameeting_search, lambda { |search| 
  search = "%#{search}%"
  where('meeting_date LIKE ? ', search)
 }
 def updated
       updated_at > 10.minutes.ago
  end
end
