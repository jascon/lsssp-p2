class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table :roles do |t|
      t.string :name,:null=>false,:limit=>25
      t.string :description,:limit=>1000
      t.boolean :active,:default=>0
      t.timestamps
    end
    add_index :roles, :name,:unique => true
  end

  def self.down
    drop_table :roles
  end
end
