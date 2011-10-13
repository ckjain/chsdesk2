class CreateUnitTypes < ActiveRecord::Migration
  def change
    create_table :unit_types do |t|
      t.string :type_name,          :limit => 100, :null => false
      t.decimal :tax_area,          :precision => 8, :scale => 2, :default => 0
      t.decimal :maintenance_area,   :precision => 8, :scale => 2, :default => 0
      t.decimal :carpet_area,       :precision => 8, :scale => 2, :default => 0
      t.decimal :built_area,        :precision => 8, :scale => 2, :default => 0
      t.decimal :super_built_area,  :precision => 8, :scale => 2, :default => 0
      t.integer :society_id,       :default => '1'

      t.timestamps
    end
    
        UnitType.create(:type_name => "3-Bedroom", :carpet_area => 1680.78, :built_area => 1870.44, :super_built_area => 2050.80, :tax_area => 2050.80)
        UnitType.create(:type_name => "4-Bedroom", :carpet_area => 1880.78, :built_area => 2070.44, :super_built_area => 2340.80, :tax_area => 2340.80)
        UnitType.create(:type_name => "2-Bedroom", :carpet_area => 680.78, :built_area => 870.44, :super_built_area => 1050.80, :tax_area => 1050.80)
        UnitType.create(:type_name => "Duplex", :carpet_area => 2380.78, :built_area => 2570.44, :super_built_area => 2890.80, :tax_area => 2890.80)
        UnitType.create(:type_name => "Penthouse", :carpet_area => 3380.78, :built_area => 3870.44, :super_built_area => 4050.80, :tax_area => 4050.80)
        UnitType.create(:type_name => "Terrace flat", :carpet_area => 1980.48, :built_area => 2270.00, :super_built_area => 2450.80, :tax_area => 2450.80)
        UnitType.create(:type_name => "1-Bedroom", :carpet_area => 380.78, :built_area => 498.34, :super_built_area => 580.77, :tax_area => 580.77)
        UnitType.create(:type_name => "Gala", :carpet_area => 480.78, :built_area => 605.44, :super_built_area => 845.80, :tax_area => 845.80)
        UnitType.create(:type_name => "Small Gala", :carpet_area => 350.78, :built_area => 490.44, :super_built_area => 560.80, :tax_area => 560.80)
        UnitType.create(:type_name => "Office", :carpet_area => 678.66, :built_area => 870.44, :super_built_area => 960.80, :tax_area => 960.80)
        UnitType.create(:type_name => "Bunglow", :carpet_area => 3680.60, :built_area => 3970.44, :super_built_area => 4350.00, :tax_area => 4350.80)
        UnitType.create(:type_name => "Tenament", :carpet_area => 2654.45, :built_area => 3000.44, :super_built_area => 3560.80, :tax_area => 3560.80)
     add_index "unit_types", ["society_id"], :name => "fk_unit_types_society_id"

  end
end
