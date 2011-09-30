class CreateVendors < ActiveRecord::Migration
  def change
    create_table :vendors do |t|
      t.integer :society_id,        :null => false
      t.string :vendor_name,        :limit => 50,  :null => false
      t.string :contact_name,       :limit => 50,  :null => false
      t.string :vendor_phone,       :limit => 50,  :null => false
      t.string :vendor_email,       :limit => 50,  :null => false
      t.boolean :is_recurring
      t.string :service_type,       :limit => 30,  :null => false
      t.decimal :tds_rate,          :precision => 4, :scale => 2
      t.decimal :service_tax_rate,  :precision => 4, :scale => 2
      t.string :stax_reg_number,    :limit => 20
      t.string :pan_number,         :limit => 20
      t.string :vat_number,         :limit => 30
      t.string :section_code,       :limit => 30
      t.string :payee_name,         :limit => 50
      t.string :address,            :limit => 250

      t.timestamps
    end
  end
end
