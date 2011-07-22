class CreateQuestions < ActiveRecord::Migration
  def self.up
    create_table :questions do |t|
      t.integer :topic_id ,:null =>false
      t.integer :subtopic_id ,:null =>false
      t.text :content ,:null =>false
      t.string :correct_answer  ,:null =>false,:limit=>100
      t.boolean :active,:default=>0
      t.timestamps
    end
  end

  def self.down
    drop_table :questions
  end
end
