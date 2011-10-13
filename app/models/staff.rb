class Staff < ActiveRecord::Base
    attr_accessible :staff_name, :gender,:staff_category,:staff_email, :staff_salary,:image,
       :age, :staff_phone, :staff_current_address, :staff_permanent_address, :society_id

        belongs_to :society
        
  mount_uploader :image, ImageUploader 
  
def updated
    self.updated_at > 5.minutes.ago
  end

scope :staff_search, lambda { |search| 
  search = "%#{search}%"
  where('staff_name LIKE ? OR staff_category LIKE ? OR staff_phone LIKE ? OR staff_current_address LIKE ?', search, search, search, search)
 }


end
