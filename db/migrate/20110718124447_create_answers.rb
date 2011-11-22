class CreateAnswers < ActiveRecord::Migration
  def self.up
    create_table :answers do |t|
      t.integer :question_id ,:null => false
      t.text :content,:null => false
      t.text :answer_file_name
      t.text :answer_content_type
      t.integer :answer_file_size


      t.timestamps
    end
    add_index :answers,:question_id
  end

  def self.down
    drop_table :answers
  end
end
