class CreateAnswers < ActiveRecord::Migration
  def self.up
    create_table :answers do |t|
      t.integer :question_id ,:null => false
      t.text :content,:null => false
      t.timestamps
    end
    add_index :answers,:question_id
  end

  def self.down
    drop_table :answers
  end
end
