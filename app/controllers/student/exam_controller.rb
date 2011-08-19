class Student::ExamController < ApplicationController
  before_filter :authenticate_user!,:must_be_student
  def index
    if params[:status] == 'new'
      @student_exam = StudentExam.includes(:certification=>:subtopic_questions).find(params[:id])
      ActiveQuestion.transaction do
        @student_exam.owned_certification.certification.subtopic_questions.each do |subtopic_question|
          question_ids = Question.where(:subtopic_id => subtopic_question.subtopic_id).order("RAND()").limit(subtopic_question.total_questions).select('id').map(&:id)
          for question in question_ids
            ActiveQuestion.create(:student_exam_id =>@student_exam.id,:subtopic_id => subtopic_question.subtopic.id,:question_id => question)
          end
        end
      end
      @student_exam.update_attribute('status',true)# Update status to true ,the user has been taken the exam
      @active_questions = @student_exam.active_questions
    else #when 'retake'
      @student_exam = StudentExam.includes(:certification).find(params[:id])
      @active_questions = @student_exam.active_questions
    end
    session[:active_question_ids] = @active_questions.map(&:id)#to find next and previous records, hold ids and get
    @active_question = @active_questions.first
    @active_question.update_attribute('viewed',true) if params[:status].eql?('new') #let user viewed the question
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
    @student_exam = StudentExam.includes(:certification).find(params[:id])
    @active_questions = @student_exam.active_questions.includes(:question)
    @active_question = @active_questions.first
    answered ,correct_answers,visited = 0,0,0;
    @active_questions.collect{ |aq| correct_answers +=1 if aq.correct_answer == aq.question.correct_answer ;
    answered +=1 if !aq.correct_answer.nil?; visited +=1 if aq.viewed? }
    wrong_answers, not_answered = (@active_questions.size - correct_answers),(@active_questions.size - answered)
    total_score = (@student_exam.certification.positive_marks * correct_answers)-(wrong_answers * @student_exam.certification.negative_marks)-(visited * @student_exam.certification.unattempted_marks)
    percentage = ((total_score.to_f / (@student_exam.no_of_questions * @student_exam.certification.positive_marks)) * 100.0).to_i
    @student_exam.update_attributes(:complete_status=>true,:visited=>visited,:not_answered=>not_answered,:answered=>answered,
                                    :answered_correctly=>correct_answers,:wrong_answers=>wrong_answers,:total_score=>total_score,:percentage=>percentage)
  end

  def review_question
    @active_question = ActiveQuestion.includes(:question=>:answers).find(params[:id])
    respond_to { |format| format.js }
  end
end
