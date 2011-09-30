class CreateMemberProperties < ActiveRecord::Migration
  def change
    create_table :member_properties do |t|
      t.integer :member_id,    :null => true
      t.integer :unit_id,      :null => false
      t.string :member_type,   :limit => 50, :default => "Regular"
      t.date :start_date,      :null => true
      t.date :end_date
      t.boolean :status,       :default => true

      t.timestamps
    end
    add_index "member_properties", ["unit_id"], :name => "property_id"
    add_index "member_properties", ["member_id"], :name => "member_id"
  end
end
