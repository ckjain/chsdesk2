class CommitteeMember < ActiveRecord::Base
  
 attr_accessible :elected, :mc_start_date,:designation,
       :duty, :signatory, :mc_end_date, :member_id, :note
        belongs_to :member
  has_many :meeting_members

scope :mc_search, lambda { |search| 
  search = "%#{search}%"
  where('designation LIKE ? OR duty LIKE ? OR mc_start_date LIKE ?', search, search, search)
 }

end
