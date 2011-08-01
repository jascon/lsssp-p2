class ActiveQuestion < ActiveRecord::Base
  serialize :correct_answer
  belongs_to :question
  belongs_to :student_exam
  belongs_to :subtopic
end
