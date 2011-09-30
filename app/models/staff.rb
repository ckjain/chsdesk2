class Staff < ActiveRecord::Base
    attr_accessible :staff_name, :gender,:staff_category,
       :age, :staff_phone, :staff_current_address, :staff_permanent_address, :society_id
        belongs_to :society

scope :staff_search, lambda { |search| 
  search = "%#{search}%"
  where('staff_name LIKE ? OR staff_category LIKE ? OR staff_phone LIKE ? OR staff_current_address LIKE ?', search, search, search, search)
 }


end
