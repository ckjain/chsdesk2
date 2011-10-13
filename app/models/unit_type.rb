class UnitType < ActiveRecord::Base
    attr_accessible :type_name, :carpet_area, :built_area, :super_built_area,
                  :tax_area, :maintenance_area, :society_id
  has_many :units
  belongs_to :unit
  belongs_to :society
  
  validates :type_name, :tax_area, :presence => true
  validates_numericality_of  :tax_area, :carpet_area, :built_area, :super_built_area
       
 scope :unittype_search, lambda { |search| 
  search = "%#{search}%"
  where('type_name LIKE ? OR carpet_area LIKE ? OR built_area LIKE ? OR super_built_area LIKE ?', search, search, search, search)
 }

  def updated_unit
       updated_at > 10.minutes.ago
  end
# sql -query to update bill fields

 # bulb to show last updated field 



end
