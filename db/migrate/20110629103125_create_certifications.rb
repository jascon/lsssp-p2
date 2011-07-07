class CreateCertifications < ActiveRecord::Migration
  def self.up
    create_table :certifications do |t|
       t.string :topic_id,:null=>false
       t.string :name,:null=>false,:limit=>50
       t.string :description,:limit=>1000
       t.boolean :active,:default=>0
       t.timestamps
    end
     add_index :certifications, :name,:unique => true
  end

  def self.down
    drop_table :certifications
  end
end
