class CreateResolutions < ActiveRecord::Migration
  def change
    create_table :resolutions do |t|
      t.text :resolution
      t.integer :proposed_by
      t.integer :seconded_by
      t.integer :member_id
      t.integer :meeting_id

      t.timestamps
    end
  end
end
