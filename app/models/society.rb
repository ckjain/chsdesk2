class Society < ActiveRecord::Base
   
  attr_accessible :society_name, :number_of_flats, :active, 
 :society_address_line1, :society_address_line2, :society_city, :society_pincode, :society_state,
 :society_country, :govt_address_line1, :govt_address_line2, :govt_address_city, :govt_address_pincode,
 :govt_address_plotnumber, :registration_number, :govt_ward_number

  validates :society_name, :presence => true, 
             :uniqueness => true
  validates_numericality_of  :number_of_flats, :presence => true
            
   # Automatically create the virtual attribute 'password_confirmation'.
#  has_many :invoices
  has_many :units
  has_many :members
#  accepts_nested_attributes_for :units, :allow_destroy => true
#  attr_reader :unit_tokens
#  attr_reader :member_tokens
scope :society_search, lambda { |search| 
  search = "%#{search}%"
  where('society_name LIKE ? OR society_city LIKE ? OR govt_address_pincode LIKE ? OR society_state LIKE ? OR number_of_flats LIKE ?', search, search, search, search, search)
 }

end
