class Bill < ActiveRecord::Base
  attr_accessible :society_id, :bill_number, :member_property_id, :from_date, :to_date, 
  :bill_date,:property_tax, :maintenance_charges, :other_charges,:service_tax,:penalty_interest, 
  :discount_amount, :current_bill_charges, :payable_amount, :image, :bill_header_id, :other_detail,
  :noc_charges, :parking_charges, :repair_fund, :sinking_fund, :unit_id, :member_id
  
  validates :bill_number, :uniqueness => true
  validates :member_property_id, :from_date, :to_date, :bill_date, :presence => true
  
  belongs_to :member_property
  belongs_to :society
  has_many :member_properties
  belongs_to :unit
  belongs_to :member
  has_many :units
  
 scope :bill_search, lambda { |search|
  search = "%#{search}%"
  joins(:unit, :member).where('units.unit_number LIKE ? OR members.last_name LIKE ? OR members.first_name LIKE ? OR bill_number LIKE ? OR current_bill_charges LIKE ?',
  search, search, search, search, search)
 }

#  def bill_create_from_unit
        bh = BillHeader.find(:last)
        mp = MemberProperty.select('id, unit_id, member_id').where('status = 1')
        bill_count = mp.count
  #     pt = joins(:member_property, :unit).select('units.noc_charges, units.parking_charges, units.property_tax, units.sinking_fund, units.repair_fund, units.other_detail, units.service_tax, units.bill_amount, units.maintenance_charge, units.other_charge, units.discount, units.id ').where('member_properties.unit_id = units.id AND member_properties.status =1')
        pt = Unit.find_by_sql "SELECT c.noc_charges, c.parking_charges, c.property_tax, c.sinking_fund, c.repair_fund, c.other_detail, c.service_tax, c.bill_amount, c.maintenance_charge, c.other_charge, c.discount, c.id 
        FROM units c, member_properties m 
        WHERE m.unit_id = c.id AND m.status =1"
    
        1.upto bill_count do |i|
        Bill.create(
        :society_id =>  bh.society_id,
        :unit_id => mp[i-1].unit_id,
        :member_id => mp[i-1].member_id,
        :member_property_id => mp[i-1].id,
        :bill_header_id => bh.id,
        :bill_number => bh.bill_number_end + i,
        :from_date => bh.from_date,
        :to_date => bh.to_date,
        :bill_date => bh.bill_date, 
        :property_tax => pt[i-1].property_tax,
        :other_charges => pt[i-1].other_charge,
        :maintenance_charges => pt[i-1].maintenance_charge,
        :repair_fund => pt[i-1].repair_fund,
        :sinking_fund => pt[i-1].sinking_fund,
        :other_detail => pt[i-1].other_detail,
        :service_tax => pt[i-1].service_tax,
        :noc_charges => pt[i-1].noc_charges,
        :parking_charges => pt[i-1].parking_charges
        )
         end
    sql = ActiveRecord::Base.connection();
    sql.execute "SET autocommit=0";
    sql.begin_db_transaction 
    id, value =
    sql.update "UPDATE `chsdesk`.`bills` SET current_bill_charges=property_tax+other_charges+maintenance_charges+
    repair_fund+sinking_fund+service_tax+parking_charges+noc_charges+penalty_interest - discount_amount";
    sql.update "UPDATE `chsdesk`.`bills` SET payable_amount=property_tax+other_charges+maintenance_charges+
    repair_fund+sinking_fund+service_tax+parking_charges+noc_charges+penalty_interest - discount_amount";
    sql.commit_db_transaction 
    value;

 # end       


end
