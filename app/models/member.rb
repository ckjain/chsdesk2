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
  has_many :meeting_members

#  default_scope :order => 'last_name,first_name ASC'
   default_scope :order => 'updated_at DESC'

  def member_name
    "#{last_name.capitalize}, #{first_name.capitalize}, #{email_id.downcase}"
  end
  def bill_member_name
    "#{last_name.capitalize}, #{first_name.capitalize}"
  end
  def mem_id_update
    sql = ActiveRecord::Base.connection();
    sql.execute "SET autocommit=0";
    sql.begin_db_transaction 
    id, value =
    sql.update "UPDATE `chsdesk`.`members` SET mem_id=id ";
    sql.commit_db_transaction 
    value;
    updated_at > 20.minutes.ago

  end
    
  scope :member_search, lambda { |search| 
  search = "%#{search}%"
  where('last_name LIKE ? OR first_name LIKE ? OR email_id LIKE ? OR mobile_phone LIKE ?', search, search, search, search)
 }

end
