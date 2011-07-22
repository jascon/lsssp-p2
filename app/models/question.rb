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

  class << self
    def search(query)
      if query
        where(:content.matches => "%#{query}%") #from meta_where gem
      else
        scoped
      end
    end
   end

end

