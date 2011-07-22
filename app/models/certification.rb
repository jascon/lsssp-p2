class Certification < ActiveRecord::Base
  # attr_accessible :topic_id,:name, :description, :active ,:price

# Associations
#-------------------------------------------------------------------------------------------------------
  belongs_to :topic, :conditions =>{:active => true }
  has_many :certificate_providers
  has_many :users, :through => :certificate_providers
#------------------------------------------------------------------------------------------------------
  has_many :subtopic_questions ,:dependent=>:destroy

 accepts_nested_attributes_for :subtopic_questions, :allow_destroy => true,:reject_if => proc { |att| att['subtopic_id'] == nil or att['total_questions'] == '' }


# START --> Validations
  #------------------------------------------------------------------------------------------------------
  validates :topic_id,:price,:duration,:no_of_questions,:positive_marks,:negative_marks,
            :unattempted_marks,:pass_marks_percentage,:presence => true
  validates :duration,:no_of_questions,:positive_marks,:negative_marks,
            :unattempted_marks,:pass_marks_percentage,:numericality=>true
  validates :name,:presence=>true, :uniqueness => true, :length => { :maximum => 25}
  validates_length_of :description, :maximum => 1000, :allow_blank => true
  #------------------------------------------------------------------------------------------------------
  # Class Methods
  #Scopes are dead in Rails3(from ref: http://www.railway.at/2010/03/09/named-scopes-are-dead/)
  #So use class methods instead
  #------------------------------------------------------------------------------------------------------
  class << self
    def search(query)
      if query
        where(:name.matches => "%#{query}%") #from meta_where gem
      else
        scoped
      end
    end

    def active
      where(:active=>true).order('name')
    end

    def recent
      order('created_at DESC').limit(4)
    end
  end
#------------------------------------------------------------------------------------------------------
end