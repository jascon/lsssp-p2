class CreateExaminations < ActiveRecord::Migration
  def self.up
    create_table :examinations do |t|
      t.integer :certification_id ,:null=>false
      t.string :name,:null=>false,:limit=>50
      t.integer :duration ,:null=>false
      t.integer :positive_marks,:negative_marks,:unattempted_marks,:null=>false
      t.integer :pass_marks_percentage ,:null=>false
      t.timestamps
    end
     add_index :examinations, :name,:unique => true
  end

  def self.down
    drop_table :examinations
  end
end
