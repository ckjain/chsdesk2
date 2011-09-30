class Bill < ActiveRecord::Base
  attr_accessible :society_id, :bill_number, :member_property_id, :from_date, :to_date, 
  :bill_date,:property_tax, :maintenance_charges, :other_charges,:service_tax,:penalty_interest, 
  :discount_amount, :current_bill_charges, :payable_amount, :image, :bill_header_id, :other_detail,
  :noc_charges, :parking_charges, :repair_fund, :sinking_fund
  validates :bill_number, :uniqueness => true
  validates :member_property_id, :from_date, :to_date, :bill_date, :presence => true
  
  belongs_to :member_property
  belongs_to :society
  belongs_to :member
  belongs_to :unit
  has_many :members, :through => :member_properties
  has_many :units, :through => :member_properties
  has_many :member_properties

 scope :bill_search, lambda { |search|
  search = "%#{search}%"
  joins(:member_property).where('member_properties.id LIKE ? OR bill_number LIKE ? 
  OR bill_date LIKE ? OR current_bill_charges LIKE ?',
  search, search, search, search)

 }

def bill_create
    bh = BillHeader.find(:last)
    mp = MemberProperty.select('id, unit_id').where('status = 1')
    bill_count = mp.count
    pt = Unit.find_by_sql "SELECT c.noc_charges, c.parking_charges, c.property_tax, c.sinking_fund, c.repair_fund, c.other_detail, c.service_tax, c.bill_amount, c.maintenance_charge, c.other_charge, c.discount, c.id 
    FROM units c, member_properties m 
    WHERE m.unit_id = c.id AND m.status =1"

    1.upto bill_count do |i|
    Bill.create(
    :society_id =>  bh.society_id,
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
    :parking_charges => pt[i-1].parking_charges,
    :discount_amount => pt[i-1].discount,
    :penalty_interest => 1,
    :current_bill_charges => pt[i-1].property_tax+pt[i-1].other_charge+
    pt[i-1].maintenance_charge+pt[i-1].repair_fund+pt[i-1].sinking_fund+
    pt[i-1].service_tax + pt[i-1].parking_charges + pt[i-1].noc_charges - pt[i-1].discount,
    :payable_amount => pt[i-1].property_tax+pt[i-1].other_charge+
    pt[i-1].maintenance_charge+pt[i-1].repair_fund+pt[i-1].sinking_fund+
    pt[i-1].service_tax + pt[i-1].parking_charges + pt[i-1].noc_charges - pt[i-1].discount
    )

    end
  end
end
