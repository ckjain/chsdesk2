class Member < ActiveRecord::Base
  
 attr_accessible :last_name, :first_name, :email_id, :is_owner, 
  :mobile_phone, :prefix, :live_here,
  :email_bills, :sms_bills, :sms_receipt, :is_mc_member, :mem_id

  validates :last_name, :first_name, :presence => true,
                    :length   => { :within => 2..30 }
  validates :mobile_phone,  :length  => { :maximum => 20 }, 
        :allow_blank => true

  has_many :member_properties
  has_many :units, :through => :member_properties
  belongs_to :unit
  has_many :committee_members

  def member_name
    "#{last_name}, #{first_name}, #{email_id}"
  end
  
    sql = ActiveRecord::Base.connection();
    sql.execute "SET autocommit=0";
    sql.begin_db_transaction 
    id, value =
    sql.update "UPDATE `chsdesk3`.`members` SET mem_id=id ";
    sql.commit_db_transaction 
    value;

  scope :member_search, lambda { |search| 
  search = "%#{search}%"
  where('last_name LIKE ? OR first_name LIKE ? OR email_id LIKE ? OR mobile_phone LIKE ?', search, search, search, search)
 }


end
