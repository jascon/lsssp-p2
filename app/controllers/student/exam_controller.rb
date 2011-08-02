class Student::ExamController < ApplicationController
  before_filter :authenticate_user!,:must_be_student
  def index
    @certification = Certification.includes({:subtopic_questions=>:subtopic}).find(params[:certification_id])
    if current_user.student_exams.exists?(:certification_id =>params[:certification_id])
      @active_questions = StudentExam.find_by_certification_id_and_user_id(@certification.id,current_user.id).active_questions
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
      # Update status to true ,the user has been taken the exam
      student_exam.update_attribute('status',true)
      @active_questions = student_exam.active_questions
      #@question =  @active_question.question.includes(:answers)
    end
    #to find next and previous records, hold ids and get
    session[:active_question_ids] = @active_questions.map(&:id)
    @active_question = @active_questions.first
    #let user viewed the question
    @active_question.update_attribute('viewed',true)
  end

  def update_answer
    #if incoming is "1,2" => "1,2".split(',')=>["1","2"]=> ["1","2"].uniq.collect{|id| id.to_i}.sort  =>[1,2]
    user_answer =  params[:correct_answer].blank? ? nil : params[:correct_answer].uniq.collect{|id| id.to_i}.sort
   @active_question = ActiveQuestion.find(params[:id])
   @active_question.update_attribute('correct_answer',user_answer)
    #render :nothing => true
    respond_to { |format| format.js }
  end

  def active_question
    if params[:previous]
      @active_question = params[:id].to_i < session[:active_question_ids].min ? ActiveQuestion.find(session[:active_question_ids].last) : ActiveQuestion.find(params[:id])
    elsif params[:next]
      @active_question = params[:id].to_i > session[:active_question_ids].max ? ActiveQuestion.find(session[:active_question_ids].first) : ActiveQuestion.find(params[:id])
    else
      @active_question = ActiveQuestion.includes(:question=>:answers).find(params[:id])
    end
    #let user viewed the question
    @active_question.update_attribute('viewed',true)
    respond_to { |format| format.js }
  end

  def finish_exam
    @student_exam = StudentExam.find(params[:exam_id])
    @active_questions = @student_exam.active_questions.includes(:question)
    @active_question = @active_questions.first
    @answered ,@correct_answers,@visited = 0,0,0;
    @student_exam.update_attributes(:complete_status=>true)
    @active_questions.collect{ |aq| @correct_answers +=1 if aq.correct_answer == aq.question.correct_answer ;
                              @answered +=1 if !aq.correct_answer.nil?; @visited +=1 if aq.viewed? }
    @wrong_answers, @not_answered = (@active_questions.size - @correct_answers),(@active_questions.size - @answered)
  end

  def review_question
    @active_question = ActiveQuestion.includes(:question=>:answers).find(params[:id])
     respond_to { |format| format.js }
  end
end
