class CreateSubtopicQuestions < ActiveRecord::Migration
  def self.up
    create_table :subtopic_questions do |t|
     # t.integer :certification_id ,:null =>false
      t.integer :examination_id ,:null =>false
      t.integer :subtopic_id ,:null =>false
      t.integer :total_questions ,:null=>false ,:limit=>3
      t.timestamps
    end
    add_index :subtopic_questions,[:examination_id,:subtopic_id],:unique => true
  end

  def self.down
    drop_table :subtopic_questions
  end
end
