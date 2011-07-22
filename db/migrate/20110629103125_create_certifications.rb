class CreateCertifications < ActiveRecord::Migration
  def self.up
    create_table :certifications do |t|
       t.string :topic_id,:null=>false
       t.string :name,:null=>false,:limit=>50
       t.decimal :price ,:null=>false
       t.string :description,:limit=>1000
       t.boolean :active,:default=>0
       t.integer :duration ,:null=>false
       t.integer :no_of_questions,:null=>false
       t.integer :positive_marks,:negative_marks,:unattempted_marks,:null=>false
       t.integer :pass_marks_percentage ,:null=>false
       t.timestamps
    end
     add_index :certifications, [:name,:topic_id],:unique => true
  end

  def self.down
    drop_table :certifications
  end
end
