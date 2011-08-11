class CreateActiveQuestions < ActiveRecord::Migration
  def self.up
    create_table :active_questions do |t|
      t.integer :student_exam_id ,:null =>false
      t.integer :subtopic_id ,:null =>false
      t.integer :question_id ,:null =>false
      t.boolean :viewed ,:default => 0
      t.string  :correct_answer ,:limit=>100
      t.integer :time_remain ,:null =>false ,:default => 0
      t.timestamps
    end
    add_index :active_questions ,[:student_exam_id,:question_id],:unique => true
    add_index :active_questions,:subtopic_id
  end

  def self.down
    drop_table :active_questions
  end
end
