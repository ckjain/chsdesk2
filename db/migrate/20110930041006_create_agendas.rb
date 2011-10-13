class CreateAgendas < ActiveRecord::Migration
  def change
    create_table :agendas do |t|
      t.text :agenda
      t.integer :meeting_id
      t.text :resolution
      t.string :proposed_by
      t.string :seconded_by
      t.timestamps
    end
  end
end
