class Unit < ActiveRecord::Base
  # table association
    attr_accessible :unit_number, :building_name, :member_id,
                  :wing_name, :floor_name, :society_id, :unit_type_id, :parking_charges,
                  :noc_charges, :property_tax, :maintenance_charge, :sinking_fund, 
                  :repair_fund, :other_charge, :other_detail, :service_tax,
                  :discount, :bill_amount,:bill_setup_id
                  
  has_many :member_properties
  has_many :members, :through => :member_properties
  belongs_to :society
  belongs_to :unit_type
  has_many :unit_types
  has_many :bill_setups
  belongs_to :bill_setup
  has_many :bills
  belongs_to :bill
# validations
  validates :unit_number, :presence => true, 
            :length  => { :within => 1..8 }
  validates :wing_name, :length  => { :maximum => 3 }
  validates :floor_name, :presence => true, 
            :length  => { :within => 1..3 }
  validates :building_name, :presence  => true,
            :length  => { :within => 1..3 }
            
  default_scope :order => 'building_name, wing_name, floor_name, unit_number ASC'


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
  
  def updated_unit

    sql = ActiveRecord::Base.connection();
    sql.execute "SET autocommit=0";
    sql.begin_db_transaction 
    id, value =
    sql.update "UPDATE `chsdesk`. `units`, `unit_types`, `bill_setups` 
    SET units.property_tax=unit_types.tax_area * bill_setups.rate_sqft_month+bill_setups.rate_unit_month, 
    units.service_tax=units.property_tax*bill_setups.service_tax_pct/100,
    units.discount=units.property_tax*bill_setups.discount_pct/100
    WHERE bill_setups.head_name ='Property Tax' AND units.unit_type_id = unit_types.id;";
    sql.update "UPDATE `chsdesk`. `units`, `unit_types`, `bill_setups` 
    SET units.sinking_fund=unit_types.maintenance_area * bill_setups.rate_sqft_month+bill_setups.rate_unit_month, 
    units.service_tax=units.service_tax+(units.sinking_fund*bill_setups.service_tax_pct/100),
    units.discount=units.discount+(units.sinking_fund*bill_setups.discount_pct/100)
    WHERE bill_setups.head_name ='Sinking fund' AND units.unit_type_id = unit_types.id;";
    sql.update "UPDATE `chsdesk`. `units`, `unit_types`, `bill_setups` 
    SET units.repair_fund=unit_types.maintenance_area * bill_setups.rate_sqft_month+bill_setups.rate_unit_month, 
    units.service_tax=units.service_tax+(units.repair_fund*bill_setups.service_tax_pct/100),
    units.discount=units.discount+(units.repair_fund*bill_setups.discount_pct/100)
    WHERE bill_setups.head_name ='Repair fund' AND units.unit_type_id = unit_types.id;";
    sql.update "UPDATE `chsdesk`. `units`, `unit_types`, `bill_setups` 
    SET units.maintenance_charge=unit_types.maintenance_area * bill_setups.rate_sqft_month+bill_setups.rate_unit_month, 
    units.service_tax=units.service_tax+(units.maintenance_charge*bill_setups.service_tax_pct/100),
    units.discount=units.discount+(units.maintenance_charge*bill_setups.discount_pct/100)
    WHERE bill_setups.head_name ='Maintenance charges' AND units.unit_type_id = unit_types.id;";
    sql.update "UPDATE `chsdesk`. `units`, `unit_types`, `bill_setups` 
    SET units.other_charge=unit_types.maintenance_area*bill_setups.rate_sqft_month+bill_setups.rate_unit_month,
    units.service_tax=units.service_tax+((unit_types.maintenance_area*bill_setups.rate_sqft_month+bill_setups.rate_unit_month)*bill_setups.service_tax_pct/100),
    units.discount=units.discount+((unit_types.maintenance_area*bill_setups.rate_sqft_month+bill_setups.rate_unit_month)*bill_setups.discount_pct/100),
    units.other_detail=bill_setups.sub_head_name
    WHERE bill_setups.head_name ='Other Charges-1' AND units.unit_type_id = unit_types.id;";
    sql.update "UPDATE `chsdesk`. `units`, `unit_types`, `bill_setups` 
    SET units.other_charge=units.other_charge+(unit_types.maintenance_area*bill_setups.rate_sqft_month+bill_setups.rate_unit_month),
    units.service_tax=units.service_tax+((unit_types.maintenance_area*bill_setups.rate_sqft_month+bill_setups.rate_unit_month)*bill_setups.service_tax_pct/100),
    units.discount=units.discount+((unit_types.maintenance_area*bill_setups.rate_sqft_month+bill_setups.rate_unit_month)*bill_setups.discount_pct/100),
    units.other_detail=units.other_detail+bill_setups.sub_head_name
    WHERE bill_setups.head_name ='Other Charges-2' AND units.unit_type_id = unit_types.id;";
    sql.update "UPDATE `chsdesk`. `units`, `unit_types`, `bill_setups` 
    SET units.other_charge=units.other_charge+(unit_types.maintenance_area*bill_setups.rate_sqft_month+bill_setups.rate_unit_month),
    units.service_tax=units.service_tax+((unit_types.maintenance_area*bill_setups.rate_sqft_month+bill_setups.rate_unit_month)*bill_setups.service_tax_pct/100),
    units.discount=units.discount+((unit_types.maintenance_area*bill_setups.rate_sqft_month+bill_setups.rate_unit_month)*bill_setups.discount_pct/100),
    units.other_detail=units.other_detail+bill_setups.sub_head_name
    WHERE bill_setups.head_name ='Other Charges-3' AND units.unit_type_id = unit_types.id;";
    sql.update "UPDATE `chsdesk`. `units`, `unit_types`, `bill_setups` 
    SET units.other_charge=units.other_charge+(unit_types.maintenance_area*bill_setups.rate_sqft_month+bill_setups.rate_unit_month),
    units.service_tax=units.service_tax+((unit_types.maintenance_area*bill_setups.rate_sqft_month+bill_setups.rate_unit_month)*bill_setups.service_tax_pct/100),
    units.discount=units.discount+((unit_types.maintenance_area*bill_setups.rate_sqft_month+bill_setups.rate_unit_month)*bill_setups.discount_pct/100),
    units.other_detail=units.other_detail+bill_setups.sub_head_name
    WHERE bill_setups.head_name ='Other Charges-4' AND units.unit_type_id = unit_types.id;";
    sql.update "UPDATE `chsdesk`. `units`, `unit_types`, `bill_setups` 
    SET units.other_charge=units.other_charge+(unit_types.maintenance_area*bill_setups.rate_sqft_month+bill_setups.rate_unit_month),
    units.service_tax=units.service_tax+((unit_types.maintenance_area*bill_setups.rate_sqft_month+bill_setups.rate_unit_month)*bill_setups.service_tax_pct/100),
    units.discount=units.discount+((unit_types.maintenance_area*bill_setups.rate_sqft_month+bill_setups.rate_unit_month)*bill_setups.discount_pct/100),
    units.other_detail=units.other_detail+bill_setups.sub_head_name
    WHERE bill_setups.head_name ='Other Charges-5' AND units.unit_type_id = unit_types.id;";
    sql.update "UPDATE `chsdesk`. `units`, `unit_types`, `bill_setups` 
    SET units.other_charge=units.other_charge+(unit_types.maintenance_area*bill_setups.rate_sqft_month+bill_setups.rate_unit_month),
    units.service_tax=units.service_tax+((unit_types.maintenance_area*bill_setups.rate_sqft_month+bill_setups.rate_unit_month)*bill_setups.service_tax_pct/100),
    units.discount=units.discount+((unit_types.maintenance_area*bill_setups.rate_sqft_month+bill_setups.rate_unit_month)*bill_setups.discount_pct/100),
    units.other_detail=units.other_detail+bill_setups.sub_head_name
    WHERE bill_setups.head_name ='Other Charges-6' AND units.unit_type_id = unit_types.id;";

    sql.update "UPDATE `chsdesk`. `units`, `unit_types`, `bill_setups`
    SET units.bill_amount=units.property_tax+units.maintenance_charge+units.sinking_fund+units.repair_fund+units.service_tax+units.other_charge-units.discount+units.noc_charges+units.parking_charges";
    sql.commit_db_transaction 
    value;
 
    updated_at > 10.minutes.ago
  end
  

    # attr_accessible



end
