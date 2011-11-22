class CreateCredits < ActiveRecord::Migration
  def self.up
    create_table :credits do |t|
      t.date :date
      t.integer :provider_id
      t.integer :amount
      t.integer :credit
      t.integer :debit
      t.integer :balance
      t.text :description,:limit=>1000
      t.integer :created_by
      t.integer :modified_by

      t.timestamps
    end
  end

  def self.down
    drop_table :credits
  end
end
