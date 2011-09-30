class Agenda < ActiveRecord::Base
   
  attr_accessible :agenda, :meeting_id
  belongs_to :meeting

end
