class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.integer :topic_id ,:null =>false
      t.integer :subtopic_id ,:null =>false
      t.text :content ,:null =>false
      t.boolean :optional,:default=>0
      t.boolean :multiple,:default=>0
      t.string :correct_answer  ,:null =>false,:limit=>100
      t.boolean :active,:default=>0
      t.string :question_file_name
      t.string :question_content_type
      t.integer :question_file_size


      t.timestamps
    end
    add_index :questions,:topic_id
    add_index :questions,:subtopic_id
  end

  def self.down
    drop_table :questions
  end
end
