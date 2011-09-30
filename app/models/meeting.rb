class Meeting < ActiveRecord::Base
   
  attr_accessible :meeting_date, :meeting_type_id, :meeting_time
  
  belongs_to :meeting_types

  has_many :meeting_members
  has_many :agendas
  has_many :resolutions

end
