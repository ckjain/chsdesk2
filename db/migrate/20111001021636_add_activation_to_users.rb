class AddActivationToUsers < ActiveRecord::Migration
  def change
    add_column :users, :activation_state, :string, :default => nil
    add_column :users, :activation_code, :string, :default => nil
    add_column :users, :activation_code_expires_at, :datetime, :default => nil
    
    add_index :users, :activation_code

  end
end
