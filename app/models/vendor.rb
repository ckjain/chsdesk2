class Vendor < ActiveRecord::Base

    attr_accessible :vendor_name, :contact_name,:vendor_phone,
       :vendor_email, :is_recurring, :service_type, :tds_rate, :society_id,
       :service_tax_rate,:stax_reg_number, :pan_number,:vat_number,
       :section_code, :payee_name,:address, :image, :image_profile

  belongs_to :society
  mount_uploader :image, ImageUploader 
  mount_uploader :image_profile, ImageUploader 

scope :vendor_search, lambda { |search| 
  search = "%#{search}%"
  where('vendor_name LIKE ? OR contact_name LIKE ? OR vendor_phone LIKE ? OR service_type LIKE ?', search, search, search, search)
 }

end
