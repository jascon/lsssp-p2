class Question < ActiveRecord::Base
 #attr_accessible :topic_id, :subtopic_id, :content, :correct_answer
  #attr_accessible :content
  serialize :correct_answer
  has_many :answers
  belongs_to :topic
  belongs_to :subtopic

  accepts_nested_attributes_for :answers,:allow_destroy => true #:reject_if => proc { |att| att['content'].eql?('unable_to_connect') },

  validates :content,:topic_id,:subtopic_id,:presence => true
  validates :correct_answer,:presence => true  , :length => { :maximum => 100 }

  scope :excluding_ids,
        lambda {|ids| (ids.empty? && relation) || where('id not in (?)', ids) }

  class << self
    def search(query)
      if query
        where(:content.matches => "%#{query}%") #from meta_where gem
      else
        scoped
      end
    end
    # to get all questions not optional(mandatory)
    def mandatory(total = nil)
      where(:optional=> true).limit(total)
    end
    #get questions by subtopic
    def by_subtopic(id)
      where(:subtopic_id=>id)
    end
    #getting subtopic question(first get all mandatory then rest of the records randomly)
    def subtopic_questions(subtopic_question)
      id ,required_questions = subtopic_question.subtopic_id,subtopic_question.total_questions
      mandatory_questions =  by_subtopic(id).mandatory(required_questions).select('id')
      total_mandatory_questions = mandatory_questions.size

      puts "#######################################################################"
      puts "Subtopic - #{id}  Mandatory.Questions : #{total_mandatory_questions} - Total Require : #{required_questions}"
      puts "Mandatory Qids  - #{mandatory_questions.map(&:id)}"
      if total_mandatory_questions < required_questions
        puts "Yes Mandatory Questions size less than total so fetch randomly other records by excluding mandatory records "
        @questions = mandatory_questions +  by_subtopic(id).excluding_ids(mandatory_questions.map(&:id)).order("RAND()").limit(required_questions - total_mandatory_questions).select('id')
      else
        @questions = mandatory_questions
      end
      puts "So All Questions:#{@questions.map(&:id)}"
      return @questions.map(&:id)
    end
  end

   # Paperclip
  has_attached_file :question,
    :styles => {
      :thumb=> "50x50#",
      :small  => "100x100>" }
end

