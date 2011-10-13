class BillSetup < ActiveRecord::Base
    
  belongs_to :society
  has_many :units
  belongs_to :unit
        
 scope :billsetup_search, lambda { |search| 
  search = "%#{search}%"
  where('head_name LIKE ? ',  search)
 }
 def updated
    updated_at > 5.minutes.ago
  end

end
