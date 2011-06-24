class CreateTopics < ActiveRecord::Migration
  def self.up
    create_table :topics do |t|
      t.string :name,:null=>false,:limit=>25
      t.string :description,:limit=>1000
      t.boolean :active
      t.timestamps
    end
     add_index :topics, :name,:unique => true
  end

  def self.down
    drop_table :topics
  end
end
