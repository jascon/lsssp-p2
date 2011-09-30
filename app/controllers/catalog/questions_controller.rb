class Catalog::QuestionsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :recent,:only=>[:index]
  layout "application",:except => [:show,:edit]
  def index
    if params[:subtopic_id]
      @questions = Question.includes({:topic=>:subtopics}).where(:subtopic_id => params[:subtopic_id]).order("subtopic_id ASC, created_at DESC")
    else
      @questions = Question.includes({:topic=>:subtopics}).search(params[:search]).order("subtopic_id ASC,topic_id ASC,created_at DESC")
    end
  end

  def show
    @question = Question.find(params[:id])
  end

  def new
    @question = Question.new(:subtopic_id=>params[:subtopic_id],:topic_id=>params[:topic_id])
    params[:no_of_answers] ||= 4
    params[:no_of_answers].to_i.times { @question.answers.build }
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @question = Question.new(params[:question])
    params[:question][:multiple] == '1' ? @question.correct_answer = params[:multiple_answers].uniq.collect{|id| id.to_i}.sort :
        @question.correct_answer = params[:single_answer].uniq.collect{|id| id.to_i}.sort
    if @question.save
      redirect_to :back, :notice => "Question created Successfully."
    else
      render :action => 'new'
    end
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    params[:question][:multiple] =='1' ? @question.correct_answer = params[:multiple_answers].uniq.collect{|id| id.to_i}.sort :
        @question.correct_answer = params[:single_answer].uniq.collect{|id| id.to_i}.sort
    if @question.update_attributes(params[:question])
      redirect_to [:catalog, @question], :notice  => "Successfully updated question."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    redirect_to catalog_questions_url, :notice => "Successfully destroyed question."
  end

  def active
    super(Question)
  end

 private
  def recent
    @topics = Topic.includes(:subtopics).order('name')
  end
end
