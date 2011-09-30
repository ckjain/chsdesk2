class UnitType < ActiveRecord::Base
    attr_accessible :type_name, :carpet_area, :built_area, :super_built_area,
                  :tax_area, :maintenance_area

  has_many :units
  belongs_to :unit
  validates :type_name, :tax_area, :presence => true
  validates_numericality_of  :tax_area, :carpet_area, :built_area, :super_built_area
       
 scope :unittype_search, lambda { |search| 
  search = "%#{search}%"
  where('type_name LIKE ? OR carpet_area LIKE ? OR built_area LIKE ? OR super_built_area LIKE ?', search, search, search, search)
 }

  def updated_unit

    sql = ActiveRecord::Base.connection();
    sql.execute "SET autocommit=0";
    sql.begin_db_transaction 
    id, value =
    sql.update "UPDATE `chsdesk3`. `units`, `unit_types`, `bill_setups` 
    SET units.property_tax=unit_types.tax_area * bill_setups.rate_sqft_month+bill_setups.rate_unit_month, 
    units.service_tax=units.property_tax*bill_setups.service_tax_pct/100,
    units.discount=units.property_tax*bill_setups.discount_pct/100
    WHERE bill_setups.head_name ='Property Tax' AND units.unit_type_id = unit_types.id;";
    sql.update "UPDATE `chsdesk3`. `units`, `unit_types`, `bill_setups` 
    SET units.sinking_fund=unit_types.maintenance_area * bill_setups.rate_sqft_month+bill_setups.rate_unit_month, 
    units.service_tax=units.service_tax+(units.sinking_fund*bill_setups.service_tax_pct/100),
    units.discount=units.discount+(units.sinking_fund*bill_setups.discount_pct/100)
    WHERE bill_setups.head_name ='Sinking fund' AND units.unit_type_id = unit_types.id;";
    sql.update "UPDATE `chsdesk3`. `units`, `unit_types`, `bill_setups` 
    SET units.repair_fund=unit_types.maintenance_area * bill_setups.rate_sqft_month+bill_setups.rate_unit_month, 
    units.service_tax=units.service_tax+(units.repair_fund*bill_setups.service_tax_pct/100),
    units.discount=units.discount+(units.repair_fund*bill_setups.discount_pct/100)
    WHERE bill_setups.head_name ='Repair fund' AND units.unit_type_id = unit_types.id;";
    sql.update "UPDATE `chsdesk3`. `units`, `unit_types`, `bill_setups` 
    SET units.maintenance_charge=unit_types.maintenance_area * bill_setups.rate_sqft_month+bill_setups.rate_unit_month, 
    units.service_tax=units.service_tax+(units.maintenance_charge*bill_setups.service_tax_pct/100),
    units.discount=units.discount+(units.maintenance_charge*bill_setups.discount_pct/100)
    WHERE bill_setups.head_name ='Maintenance charges' AND units.unit_type_id = unit_types.id;";
    sql.update "UPDATE `chsdesk3`. `units`, `unit_types`, `bill_setups` 
    SET units.other_charge=unit_types.maintenance_area*bill_setups.rate_sqft_month+bill_setups.rate_unit_month,
    units.service_tax=units.service_tax+((unit_types.maintenance_area*bill_setups.rate_sqft_month+bill_setups.rate_unit_month)*bill_setups.service_tax_pct/100),
    units.discount=units.discount+((unit_types.maintenance_area*bill_setups.rate_sqft_month+bill_setups.rate_unit_month)*bill_setups.discount_pct/100),
    units.other_detail=bill_setups.sub_head_name
    WHERE bill_setups.head_name ='Other Charges-1' AND units.unit_type_id = unit_types.id;";
    sql.update "UPDATE `chsdesk3`. `units`, `unit_types`, `bill_setups` 
    SET units.other_charge=units.other_charge+(unit_types.maintenance_area*bill_setups.rate_sqft_month+bill_setups.rate_unit_month),
    units.service_tax=units.service_tax+((unit_types.maintenance_area*bill_setups.rate_sqft_month+bill_setups.rate_unit_month)*bill_setups.service_tax_pct/100),
    units.discount=units.discount+((unit_types.maintenance_area*bill_setups.rate_sqft_month+bill_setups.rate_unit_month)*bill_setups.discount_pct/100),
    units.other_detail=units.other_detail+bill_setups.sub_head_name
    WHERE bill_setups.head_name ='Other Charges-2' AND units.unit_type_id = unit_types.id;";
    sql.update "UPDATE `chsdesk3`. `units`, `unit_types`, `bill_setups` 
    SET units.other_charge=units.other_charge+(unit_types.maintenance_area*bill_setups.rate_sqft_month+bill_setups.rate_unit_month),
    units.service_tax=units.service_tax+((unit_types.maintenance_area*bill_setups.rate_sqft_month+bill_setups.rate_unit_month)*bill_setups.service_tax_pct/100),
    units.discount=units.discount+((unit_types.maintenance_area*bill_setups.rate_sqft_month+bill_setups.rate_unit_month)*bill_setups.discount_pct/100),
    units.other_detail=units.other_detail+bill_setups.sub_head_name
    WHERE bill_setups.head_name ='Other Charges-3' AND units.unit_type_id = unit_types.id;";
    sql.update "UPDATE `chsdesk3`. `units`, `unit_types`, `bill_setups` 
    SET units.other_charge=units.other_charge+(unit_types.maintenance_area*bill_setups.rate_sqft_month+bill_setups.rate_unit_month),
    units.service_tax=units.service_tax+((unit_types.maintenance_area*bill_setups.rate_sqft_month+bill_setups.rate_unit_month)*bill_setups.service_tax_pct/100),
    units.discount=units.discount+((unit_types.maintenance_area*bill_setups.rate_sqft_month+bill_setups.rate_unit_month)*bill_setups.discount_pct/100),
    units.other_detail=units.other_detail+bill_setups.sub_head_name
    WHERE bill_setups.head_name ='Other Charges-4' AND units.unit_type_id = unit_types.id;";
    sql.update "UPDATE `chsdesk3`. `units`, `unit_types`, `bill_setups` 
    SET units.other_charge=units.other_charge+(unit_types.maintenance_area*bill_setups.rate_sqft_month+bill_setups.rate_unit_month),
    units.service_tax=units.service_tax+((unit_types.maintenance_area*bill_setups.rate_sqft_month+bill_setups.rate_unit_month)*bill_setups.service_tax_pct/100),
    units.discount=units.discount+((unit_types.maintenance_area*bill_setups.rate_sqft_month+bill_setups.rate_unit_month)*bill_setups.discount_pct/100),
    units.other_detail=units.other_detail+bill_setups.sub_head_name
    WHERE bill_setups.head_name ='Other Charges-5' AND units.unit_type_id = unit_types.id;";
    sql.update "UPDATE `chsdesk3`. `units`, `unit_types`, `bill_setups` 
    SET units.other_charge=units.other_charge+(unit_types.maintenance_area*bill_setups.rate_sqft_month+bill_setups.rate_unit_month),
    units.service_tax=units.service_tax+((unit_types.maintenance_area*bill_setups.rate_sqft_month+bill_setups.rate_unit_month)*bill_setups.service_tax_pct/100),
    units.discount=units.discount+((unit_types.maintenance_area*bill_setups.rate_sqft_month+bill_setups.rate_unit_month)*bill_setups.discount_pct/100),
    units.other_detail=units.other_detail+bill_setups.sub_head_name
    WHERE bill_setups.head_name ='Other Charges-6' AND units.unit_type_id = unit_types.id;";

    sql.update "UPDATE `chsdesk3`. `units`, `unit_types`, `bill_setups`
    SET units.bill_amount=units.property_tax+units.maintenance_charge+units.sinking_fund+units.repair_fund+units.service_tax+units.other_charge-units.discount+units.noc_charges+units.parking_charges";
    sql.commit_db_transaction 
    value;
 
    updated_at > 10.minutes.ago
  end
  
 
# sql -query to update bill fields

 # bulb to show last updated field 



end
