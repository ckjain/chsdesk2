class CreateAgendas < ActiveRecord::Migration
  def change
    create_table :agendas do |t|
      t.text :agenda
      t.integer :meeting_id

      t.timestamps
    end
  end
end
