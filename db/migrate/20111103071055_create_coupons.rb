class CreateCoupons < ActiveRecord::Migration
  def self.up
    create_table :coupons do |t|
      t.text :coupon
      t.integer :provider_id
      t.integer :student_id
      t.boolean :status, :default=>0
      t.date :created_date
      t.date :redemption_date
      t.integer :created_by
      t.integer :updated_by


      t.timestamps
    end
  end

  def self.down
    drop_table :coupons
  end
end
