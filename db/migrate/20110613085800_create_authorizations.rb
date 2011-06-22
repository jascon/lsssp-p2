class CreateAuthorizations < ActiveRecord::Migration
  def self.up
    create_table :authorizations do |t|
      t.integer :role_id,:null=>false
      t.string :name,:null=>false,:limit=>25# for Ability model can :manage User(this is name)
      t.boolean :manage_all,:default=>0
      t.timestamps
    end
    add_index :authorizations, [:name,:role_id],:unique => true
  end

  def self.down
    drop_table :authorizations
  end
end
