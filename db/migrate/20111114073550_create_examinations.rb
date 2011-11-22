class CreateExaminations < ActiveRecord::Migration
  def self.up
    create_table :examinations do |t|
      t.string :name,:null=>false
      t.integer :certification_id,:null=>false
      t.integer :topic_id, :null=>false
      t.integer :no_of_questions
      t.integer :positive_marks,:null=>false
      t.decimal :negative_marks,:null=>false ,:precision => 10, :scale => 2
      t.decimal :unattempted_marks,:null=>false ,:precision => 10, :scale => 2
      t.integer :pass_marks_percentage ,:null=>false
      t.boolean :active,:default=>0
      t.integer :duration
      t.string :description, :limit=>1000

      t.timestamps
    end
  end

  def self.down
    drop_table :examinations
  end
end
