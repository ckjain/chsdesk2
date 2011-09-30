class MeetingType < ActiveRecord::Base
  attr_accessible :types
  belongs_to :meeting
end
