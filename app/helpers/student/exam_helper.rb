module Student::ExamHelper
# Check question status viewed or,answered or unanswered
  def active_question_status(active_question)
     if active_question.correct_answer.nil? and active_question.viewed?
       return 'viewed'
     elsif !active_question.correct_answer.nil? and active_question.viewed?
       return 'completed'
     elsif active_question.correct_answer.nil? and !active_question.viewed?
       return 'loaded'
     end
  end

end
