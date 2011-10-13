class CreateBillSetups < ActiveRecord::Migration
  def change
    create_table :bill_setups do |t|
      t.integer :society_id,       :default => '1'
      t.string :head_name,         :limit => 100
      t.string :sub_head_name,     :limit => 100
      t.decimal :rate_sqft_month,  :precision => 7, :scale => 4
      t.decimal :rate_unit_month,  :precision => 8, :scale => 2
      t.decimal :service_tax_pct,  :precision => 5, :scale => 2
      t.decimal :discount_pct,     :precision => 4, :scale => 2

      t.timestamps
    end
        BillSetup.create(:head_name => "Property Tax", :sub_head_name => "Property Tax",:rate_sqft_month => 0.00, :rate_unit_month => 0.00, :service_tax_pct => 0.00, :discount_pct => 0.00 )
        BillSetup.create(:head_name => "Sinking Fund", :sub_head_name => "Sinking Fund",:rate_sqft_month => 0.25, :rate_unit_month => 0, :service_tax_pct => 0, :discount_pct => 0.00)
        BillSetup.create(:head_name => "Repair Fund", :sub_head_name => "Repair Fund",:rate_sqft_month => 0.75, :rate_unit_month => 0, :service_tax_pct => 0, :discount_pct => 0.00)
        BillSetup.create(:head_name => "Maintenance Charges", :sub_head_name => "Maintenance Charges",:rate_sqft_month => 0, :rate_unit_month => 0, :service_tax_pct => 0, :discount_pct => 0.00)
        BillSetup.create(:head_name => "Other Charges-1", :sub_head_name => "Security Charges",:rate_sqft_month => 0, :rate_unit_month => 0, :service_tax_pct => 0, :discount_pct => 0.00)
        BillSetup.create(:head_name => "Other Charges-2", :sub_head_name => "Water Charges",:rate_sqft_month => 0, :rate_unit_month => 0, :service_tax_pct => 0, :discount_pct => 0.00)
        BillSetup.create(:head_name => "Other Charges-3", :rate_sqft_month => 0, :rate_unit_month => 0, :service_tax_pct => 0, :discount_pct => 0.00)
        BillSetup.create(:head_name => "Other Charges-4", :rate_sqft_month => 0, :rate_unit_month => 0, :service_tax_pct => 0, :discount_pct => 0.00)
        BillSetup.create(:head_name => "Other Charges-5", :rate_sqft_month => 0, :rate_unit_month => 0, :service_tax_pct => 0, :discount_pct => 0.00)
        BillSetup.create(:head_name => "Other Charges-6", :rate_sqft_month => 0, :rate_unit_month => 0, :service_tax_pct => 0, :discount_pct => 0.00)

      add_index "bill_setups", ["society_id"], :name => "fk_bill_setup_society_id"

  end
end
