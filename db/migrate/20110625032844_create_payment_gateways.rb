class CreatePaymentGateways < ActiveRecord::Migration
  def self.up
    create_table :payment_gateways do |t|
      t.string :api_name,:null=>false,:limit=>50
      t.string :url,:null=>false,:limit=>2000
      t.string :username,:null=>false,:limit=>25
      t.string :password,:null=>false,:limit=>25
      t.boolean :active,:default=>0
      t.timestamps
    end
    add_index :payment_gateways,:api_name,:unique => true
  end

  def self.down
    drop_table :payment_gateways
  end
end
