class CreateBillHeaders < ActiveRecord::Migration
  def change
    create_table :bill_headers do |t|
      t.date :bill_date,                    :null => false
      t.date :from_date,                    :null => false
      t.date :to_date,                      :null => false
      t.string :bill_cycle,                 :limit => 30, :null => false
      t.integer :grace_period
      t.integer :days_to_discount
      t.integer :society_id,                :null => false
      t.integer :bill_number_start
      t.integer :bill_number_end
      t.string :bill_number_format,         :limit => 30, :null => false
      t.boolean :locked_period,             :default => false

      t.timestamps
    end
  end
end
