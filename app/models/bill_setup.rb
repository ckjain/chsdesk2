class BillSetup < ActiveRecord::Base
    
  belongs_to :society
         
 scope :billsetup_search, lambda { |search| 
  search = "%#{search}%"
  where('head_name LIKE ? ',  search)
 }

end
