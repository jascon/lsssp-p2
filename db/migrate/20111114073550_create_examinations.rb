class CreateExaminations < ActiveRecord::Migration
  def self.up
    create_table :examinations do |t|
      t.string :name
      t.text :description
      t.decimal :price,:precision => 10, :scale => 2
      t.decimal :discount_price,:precision => 10, :scale => 2
      t.boolean :active, :default=>0
      t.integer :created_by
      t.integer :updated_by

      t.timestamps
    end
  end

  def self.down
    drop_table :examinations
  end
end
