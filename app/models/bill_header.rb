class BillHeader < ActiveRecord::Base
    attr_accessible :bill_date,:from_date,:to_date, :bill_cycle, :grace_period,
   :days_to_discount, :society_id, :bill_number_start,:bill_number_end,
   :bill_number_format, :locked_period     

  belongs_to :society
         
 scope :billheader_search, lambda { |search| 
  search = "%#{search}%"
  where('bill_number_start LIKE ? ',  search)
 }

end
