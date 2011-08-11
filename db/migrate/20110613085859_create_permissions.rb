class CreatePermissions < ActiveRecord::Migration
  def self.up
    create_table :permissions do |t|     
      t.integer :authorization_id,:null=>false
      t.string :name,:null=>false,:limit=>25 # for Ability model can :update(this is name.to_sym) User
      t.timestamps
    end
    add_index :permissions, :authorization_id
  end

  def self.down
    drop_table :permissions
  end
end
