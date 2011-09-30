# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110930041047) do

  create_table "agendas", :force => true do |t|
    t.text     "agenda"
    t.integer  "meeting_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bill_headers", :force => true do |t|
    t.date     "bill_date",                                           :null => false
    t.date     "from_date",                                           :null => false
    t.date     "to_date",                                             :null => false
    t.string   "bill_cycle",         :limit => 30,                    :null => false
    t.integer  "grace_period"
    t.integer  "days_to_discount"
    t.integer  "society_id",                                          :null => false
    t.integer  "bill_number_start"
    t.integer  "bill_number_end"
    t.string   "bill_number_format", :limit => 30,                    :null => false
    t.boolean  "locked_period",                    :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bill_setups", :force => true do |t|
    t.integer  "society_id",                                                    :null => false
    t.string   "head_name",        :limit => 100
    t.string   "sub_head_name",    :limit => 100
    t.decimal  "rate_sqft_month",                 :precision => 7, :scale => 4
    t.decimal  "rate_unit_month",                 :precision => 8, :scale => 2
    t.decimal  "service_tax_pct",                 :precision => 5, :scale => 2
    t.integer  "days_to_discount"
    t.decimal  "discount_pct",                    :precision => 4, :scale => 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bill_setups", ["society_id"], :name => "fk_bill_setup_society_id"

  create_table "bills", :force => true do |t|
    t.integer  "society_id",                                                           :null => false
    t.integer  "bill_header_id",                                                       :null => false
    t.integer  "bill_number",                                                          :null => false
    t.integer  "member_property_id",                                                   :null => false
    t.date     "from_date",                                                            :null => false
    t.date     "to_date",                                                              :null => false
    t.date     "bill_date",                                                            :null => false
    t.decimal  "property_tax",         :precision => 8,  :scale => 2, :default => 0.0
    t.decimal  "repair_fund",          :precision => 7,  :scale => 2, :default => 0.0
    t.decimal  "sinking_fund",         :precision => 7,  :scale => 2, :default => 0.0
    t.decimal  "parking_charges",      :precision => 7,  :scale => 2, :default => 0.0
    t.decimal  "noc_charges",          :precision => 7,  :scale => 2, :default => 0.0
    t.decimal  "maintenance_charges",  :precision => 8,  :scale => 2, :default => 0.0
    t.decimal  "other_charges",        :precision => 8,  :scale => 2, :default => 0.0
    t.string   "other_detail"
    t.decimal  "service_tax",          :precision => 8,  :scale => 2, :default => 0.0
    t.decimal  "penalty_interest",     :precision => 8,  :scale => 2, :default => 0.0
    t.decimal  "discount_amount",      :precision => 6,  :scale => 2, :default => 0.0
    t.decimal  "current_bill_charges", :precision => 10, :scale => 2, :default => 0.0
    t.decimal  "payable_amount",       :precision => 10, :scale => 2, :default => 0.0
    t.string   "image"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bills", ["member_property_id"], :name => "fk_member_property_id"

  create_table "committee_members", :force => true do |t|
    t.boolean  "elected",                     :default => true
    t.date     "mc_start_date"
    t.string   "designation",   :limit => 50, :default => "Committee Member"
    t.string   "duty",          :limit => 50, :default => "Standard"
    t.boolean  "signatory",                   :default => false
    t.date     "mc_end_date"
    t.integer  "member_id"
    t.text     "note"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meeting_members", :force => true do |t|
    t.integer  "meeting_id"
    t.integer  "member_id"
    t.integer  "attending_member"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meeting_types", :force => true do |t|
    t.string   "types"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "meetings", :force => true do |t|
    t.date     "meeting_date"
    t.time     "meeting_time"
    t.integer  "meeting_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "member_properties", :force => true do |t|
    t.integer  "member_id"
    t.integer  "unit_id",                                          :null => false
    t.string   "member_type", :limit => 50, :default => "Regular"
    t.date     "start_date"
    t.date     "end_date"
    t.boolean  "status",                    :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "member_properties", ["member_id"], :name => "member_id"
  add_index "member_properties", ["unit_id"], :name => "property_id"

  create_table "members", :force => true do |t|
    t.string   "first_name",   :limit => 50,                    :null => false
    t.string   "last_name",    :limit => 50,                    :null => false
    t.string   "prefix",       :limit => 10,                    :null => false
    t.string   "mobile_phone", :limit => 20,                    :null => false
    t.string   "email_id",     :limit => 50,                    :null => false
    t.boolean  "is_owner",                   :default => true,  :null => false
    t.boolean  "live_here",                  :default => true,  :null => false
    t.boolean  "email_bills",                :default => true,  :null => false
    t.boolean  "sms_bills",                  :default => true,  :null => false
    t.boolean  "sms_receipt",                :default => true,  :null => false
    t.boolean  "is_mc_member",               :default => false, :null => false
    t.integer  "mem_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "members", ["email_id"], :name => "index_members_on_email_id", :unique => true

  create_table "resolutions", :force => true do |t|
    t.text     "resolution"
    t.integer  "proposed_by"
    t.integer  "seconded_by"
    t.integer  "member_id"
    t.integer  "meeting_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "societies", :force => true do |t|
    t.string   "society_name",            :limit => 100,                           :null => false
    t.integer  "number_of_flats"
    t.boolean  "active",                                 :default => true
    t.string   "society_address_line1",   :limit => 200
    t.string   "society_address_line2",   :limit => 200
    t.string   "society_city",            :limit => 50,  :default => "MUMBAI"
    t.string   "society_pincode",         :limit => 20
    t.string   "society_state",           :limit => 50,  :default => "MAHARASTRA"
    t.string   "society_country",         :limit => 50,  :default => "INDIA"
    t.string   "govt_address_line1",      :limit => 200
    t.string   "govt_address_line2",      :limit => 200
    t.string   "govt_address_city",       :limit => 50,  :default => "MUMBAI"
    t.string   "govt_address_pincode",    :limit => 20
    t.string   "govt_address_plotnumber", :limit => 50
    t.string   "registration_number",     :limit => 50
    t.string   "govt_ward_number",        :limit => 50
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "staffs", :force => true do |t|
    t.string   "staff_name",              :limit => 100,                   :null => false
    t.string   "gender",                  :limit => 10,                    :null => false
    t.string   "staff_category",          :limit => 50,                    :null => false
    t.integer  "age"
    t.string   "staff_email",             :limit => 100
    t.string   "staff_phone",             :limit => 15,                    :null => false
    t.string   "staff_current_address",   :limit => 200,                   :null => false
    t.string   "staff_permanent_address", :limit => 200,                   :null => false
    t.boolean  "active",                                 :default => true
    t.date     "joining_date"
    t.integer  "staff_salary"
    t.binary   "photo_id"
    t.binary   "staff_photo"
    t.integer  "society_id",                                               :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "unit_types", :force => true do |t|
    t.string   "type_name",        :limit => 100,                                                :null => false
    t.decimal  "tax_area",                        :precision => 8, :scale => 2, :default => 0.0
    t.decimal  "maintenance_area",                :precision => 8, :scale => 2, :default => 0.0
    t.decimal  "carpet_area",                     :precision => 8, :scale => 2, :default => 0.0
    t.decimal  "built_area",                      :precision => 8, :scale => 2, :default => 0.0
    t.decimal  "super_built_area",                :precision => 8, :scale => 2, :default => 0.0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "units", :force => true do |t|
    t.string   "unit_number",        :limit => 20,                                                  :null => false
    t.string   "wing_name",          :limit => 10,                                                  :null => false
    t.string   "building_name",      :limit => 10,                                                  :null => false
    t.string   "floor_name",         :limit => 10,                                                  :null => false
    t.decimal  "noc_charges",                      :precision => 7, :scale => 2, :default => 0.0
    t.decimal  "parking_charges",                  :precision => 7, :scale => 2, :default => 0.0
    t.decimal  "property_tax",                     :precision => 8, :scale => 2, :default => 0.0
    t.decimal  "maintenance_charge",               :precision => 8, :scale => 2, :default => 0.0
    t.decimal  "sinking_fund",                     :precision => 8, :scale => 2, :default => 0.0
    t.decimal  "repair_fund",                      :precision => 8, :scale => 2, :default => 0.0
    t.decimal  "service_tax",                      :precision => 8, :scale => 2, :default => 0.0
    t.decimal  "discount",                         :precision => 8, :scale => 2, :default => 0.0
    t.decimal  "other_charge",                     :precision => 8, :scale => 2, :default => 0.0
    t.decimal  "bill_amount",                      :precision => 9, :scale => 2, :default => 0.0
    t.string   "other_detail"
    t.boolean  "assigned",                                                       :default => false
    t.integer  "unit_type_id",                                                                      :null => false
    t.integer  "society_id",                                                                        :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vendors", :force => true do |t|
    t.integer  "society_id",                                                    :null => false
    t.string   "vendor_name",      :limit => 50,                                :null => false
    t.string   "contact_name",     :limit => 50,                                :null => false
    t.string   "vendor_phone",     :limit => 50,                                :null => false
    t.string   "vendor_email",     :limit => 50,                                :null => false
    t.boolean  "is_recurring"
    t.string   "service_type",     :limit => 30,                                :null => false
    t.decimal  "tds_rate",                        :precision => 4, :scale => 2
    t.decimal  "service_tax_rate",                :precision => 4, :scale => 2
    t.string   "stax_reg_number",  :limit => 20
    t.string   "pan_number",       :limit => 20
    t.string   "vat_number",       :limit => 30
    t.string   "section_code",     :limit => 30
    t.string   "payee_name",       :limit => 50
    t.string   "address",          :limit => 250
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
