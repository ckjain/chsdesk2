class CreateBillHeaders < ActiveRecord::Migration
  def change
    create_table :bill_headers do |t|
      t.date :bill_date,                    :null => false
      t.date :from_date,                    :null => false
      t.date :to_date,                      :null => false
      t.integer :bill_cycle,                :default => '1'
      t.integer :grace_period,              :default => '15'
      t.integer :days_to_discount,          :default => '15'
      t.integer :society_id,                :default => '1'
      t.integer :bill_number_start,         :default => '1'
      t.integer :bill_number_end,           :default => '1'
      t.string :bill_number_format,         :limit => 30, :null => false
      t.boolean :locked_period,             :default => false

      t.timestamps
    end
  end
end
