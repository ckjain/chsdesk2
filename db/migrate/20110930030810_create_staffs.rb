class CreateStaffs < ActiveRecord::Migration
  def change
    create_table :staffs do |t|
      t.string :staff_name,                 :limit => 100, :null => false
      t.string :gender,                     :limit => 10,  :null => false
      t.string :staff_category,             :limit => 50,  :null => false
      t.integer :age,                       :precision => 3, :scale => 0
      t.string :staff_email,                :limit => 100
      t.string :staff_phone,                :limit => 15, :null => false
      t.string :staff_current_address,      :limit => 200, :null => false
      t.string :staff_permanent_address,    :limit => 200, :null => false
      t.boolean :active,                    :default => true
      t.date :joining_date
      t.integer :staff_salary,              :precision => 8, :scale => 0
      t.binary :photo_id
      t.binary :staff_photo
      t.integer :society_id,                :null => false

      t.timestamps
    end
  end
end
