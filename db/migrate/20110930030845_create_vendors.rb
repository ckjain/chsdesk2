class CreateVendors < ActiveRecord::Migration
  def change
    create_table :vendors do |t|
      t.integer :society_id,      :default => '1'
      t.string :vendor_name,        :limit => 50,  :null => false
      t.string :contact_name,       :limit => 50,  :null => false
      t.string :vendor_phone,       :limit => 50
      t.string :vendor_email,       :limit => 50
      t.boolean :is_recurring
      t.string :service_type,       :limit => 30
      t.decimal :tds_rate,          :precision => 4, :scale => 2
      t.decimal :service_tax_rate,  :precision => 4, :scale => 2
      t.string :stax_reg_number,    :limit => 20
      t.string :pan_number,         :limit => 20
      t.string :vat_number,         :limit => 30
      t.string :section_code,       :limit => 30
      t.string :payee_name,         :limit => 50
      t.string :address,            :limit => 250
      t.string :vendor_pincode,     :limit => 20
      t.string :vendor_city,        :limit => 50, :default => 'Mumbai'
      t.string :vendor_state,       :limit => 50, :default => 'Maharastra'
      t.string :vendor_country,     :limit => 50, :default => 'India'
      t.string :image
      t.string :image_profile
      

      t.timestamps
    end
  end
end
