class StudentExam < ActiveRecord::Base
  belongs_to :user
  belongs_to :certification
  has_many :active_questions,:order=>'id'
end
