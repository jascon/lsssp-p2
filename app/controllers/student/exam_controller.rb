class Student::ExamController < ApplicationController
   before_filter :authenticate_user!,:must_be_student
  def index
    @certification = Certification.includes({:subtopic_questions=>:subtopic}).find(params[:certification_id])
    if current_user.student_exams.exists?(:certification_id =>params[:certification_id])
      puts "#############   Already Taken"
       @active_questions = StudentExam.find_by_certification_id_and_user_id(@certification.id,current_user.id).active_questions
      @active_question = @active_questions.first
    else
      student_exam = current_user.student_exams.create(:certification_id => @certification.id)
      ActiveQuestion.transaction do
        @certification.subtopic_questions.each do |subtopic_question|
          question_ids = Question.where(:subtopic_id => subtopic_question.subtopic.id).order("RAND()").limit(subtopic_question.total_questions).select('id').map(&:id)
          for question in question_ids
            ActiveQuestion.create(:student_exam_id => student_exam.id,:subtopic_id => subtopic_question.subtopic.id,:question_id => question)
          end
        end
      end
      @active_questions = student_exam.active_questions
      @active_question = @active_questions.first
      #@question =  @active_question.question.includes(:answers)
    end
  end

  def update_answer
    #if incoming is "1,2" => "1,2".split(',')=>["1","2"]=> ["1","2"].uniq.collect{|id| id.to_i}.sort  =>[1,2]
    user_answer =  params[:correct_answer].blank? ? nil : params[:correct_answer].uniq.collect{|id| id.to_i}.sort
    ActiveQuestion.find(params[:id]).update_attribute('correct_answer',user_answer)
    #render :nothing => true
    respond_to { |format| format.js }
  end

  def active_question
    @active_question = ActiveQuestion.find(params[:id])
    respond_to { |format| format.js }
  end
end
