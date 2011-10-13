class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.integer :society_id,            :default => '1'
      t.integer :unit_id
      t.integer :member_id
      t.integer :bill_header_id,        :null => false
      t.integer :bill_number,           :limit => 25, :null => false
      t.integer :member_property_id,    :null => false
      t.date :from_date,                :null => false
      t.date :to_date,                  :null => false
      t.date :bill_date,                :null => false
      t.decimal :property_tax,          :precision => 8, :scale => 2, :default => 0
      t.decimal :repair_fund,           :precision => 7, :scale => 2, :default => 0
      t.decimal :sinking_fund,          :precision => 7, :scale => 2, :default => 0
      t.decimal :parking_charges,       :precision => 7, :scale => 2, :default => 0
      t.decimal :noc_charges,           :precision => 7, :scale => 2, :default => 0
      t.decimal :maintenance_charges,   :precision => 8, :scale => 2, :default => 0
      t.decimal :other_charges,         :precision => 8, :scale => 2, :default => 0
      t.string  :other_detail,          :null => true
      t.decimal :service_tax,           :precision => 8, :scale => 2, :default => 0
      t.decimal :penalty_interest,      :precision => 8, :scale => 2, :default => 0
      t.decimal :discount_amount,       :precision => 6, :scale => 2, :default => 0
      t.decimal :current_bill_charges,  :precision => 10, :scale => 2, :default => 0
      t.decimal :payable_amount,        :precision => 10, :scale => 2, :default => 0
      t.string :image
      
      t.timestamps
    end
      add_index "bills", ["member_property_id"], :name => "fk_member_property_id"

  end
end
