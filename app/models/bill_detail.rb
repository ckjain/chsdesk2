class BillDetail < ActiveRecord::Base
  attr_accessible :bill_head_id, :bill_id, :head, :net_amount,
  :mandatory, :is_sub_head, :service_tax, :gross_amount

  belongs_to :bill

 def create_bill_detail
   
   head_count = BillSetup.head_name.count
   net_amount = BillSetup.rate_sqft_month * UnitType.tax_area
       1.upto head_count do |x|
         BillDetail.create(
         :head => BillSetup.head_name(x),
         :net_amount => net_amount + (:net_amount),
         :maintenance_charges => bill_details.maintenance_charges,
         :other_charges => bill_details.other_charges,
         :service_tax => bill_details.service_tax,
         :penalty_interest => bill_details.penalty_interest,
         :discount_amount => bill_details.discount_amount)
       end
 end
end
