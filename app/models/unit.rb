class Unit < ActiveRecord::Base
  # table association
    attr_accessible :unit_number, :building_name, :member_id,
                  :wing_name, :floor_name, :society_id, :unit_type_id, :parking_charges,
                  :noc_charges, :property_tax, :maintenance_charge, :sinking_fund, 
                  :repair_fund, :other_charge, :other_detail, :service_tax,
                  :discount, :bill_amount 
                  
  has_many :member_properties
  has_many :members, :through => :member_properties
  belongs_to :society
  belongs_to :unit_type
  has_many :unit_types

# validations
  validates :unit_number, :presence => true, 
            :length  => { :within => 1..8 }
  validates :wing_name, :length  => { :maximum => 3 }
  validates :floor_name, :presence => true, 
            :length  => { :within => 1..3 }
  validates :building_name, :presence  => true,
            :length  => { :within => 1..3 }

#  define search fields
scope :unit_search, lambda { |search| 
  search = "%#{search}%"
  joins(:unit_type).where('unit_types.type_name LIKE ?  OR unit_number LIKE ? 
  OR building_name LIKE ? OR floor_name LIKE ? OR wing_name LIKE ?', 
  search, search, search, search, search)
 }

  def unit_name
    "#{building_name}, #{wing_name}, #{unit_number}"
  end
    # sql query--sum of all the fields to arrive at final bill amount


    # attr_accessible



end
