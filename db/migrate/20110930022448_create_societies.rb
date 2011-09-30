class CreateSocieties < ActiveRecord::Migration
  def change
    create_table :societies do |t|
      t.string :society_name,             :limit => 100, :null => false
      t.integer :number_of_flats       
      t.boolean :active,                  :default => true
      t.string :society_address_line1,    :limit => 200
      t.string :society_address_line2,    :limit => 200
      t.string :society_city,             :limit => 50,  :default => "MUMBAI"
      t.string :society_pincode,          :limit => 20
      t.string :society_state,            :limit => 50,  :default => "MAHARASTRA"
      t.string :society_country,          :limit => 50,  :default => "INDIA"
      t.string :govt_address_line1,       :limit => 200
      t.string :govt_address_line2,       :limit => 200
      t.string :govt_address_city,        :limit => 50,  :default => "MUMBAI"
      t.string :govt_address_pincode,     :limit => 20
      t.string :govt_address_plotnumber,   :limit => 50
      t.string :registration_number,      :limit => 50
      t.string :govt_ward_number,         :limit => 50

      t.timestamps
    end
  end
end
