class CreateStudentExams < ActiveRecord::Migration
  def self.up
    create_table :student_exams do |t|
      t.integer :user_id,:null =>false
      t.integer :certification_id,:null=>false
      t.boolean :status, :default =>0
      t.integer :number_of_attempts, :default =>0
      t.boolean :complete_status, :default =>0
      t.integer :time_remain
      t.integer :questions_answered
      t.integer :total_score
      t.boolean :result_status
      t.timestamps
    end
    add_index :student_exams,[:user_id,:certification_id],:unique => true
  end

  def self.down
    drop_table :student_exams
  end
end
