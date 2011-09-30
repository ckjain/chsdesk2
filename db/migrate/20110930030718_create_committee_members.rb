class CreateCommitteeMembers < ActiveRecord::Migration
  def change
    create_table :committee_members do |t|
      t.boolean :elected,                :default => true
      t.date :mc_start_date
      t.string :designation,             :limit => 50,  :default => "Committee Member"
      t.string :duty,                    :limit => 50,  :default => "Standard"
      t.boolean :signatory,              :default => false
      t.date :mc_end_date
      t.integer :member_id
      t.text :note

      t.timestamps
    end
  end
end
