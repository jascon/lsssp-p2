class Topic < ActiveRecord::Base
  attr_accessible :name, :description, :active
  has_many :certifications,:dependent => :destroy
  has_many :subtopics ,:dependent => :destroy

   accepts_nested_attributes_for :subtopics,:allow_destroy => true

  # START --> Validations
  #------------------------------------------------------------------------------------------------------
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

    def recent
      order('created_at DESC').limit(4)
    end

    def active
      where(:active => true).order('name')
    end
  end
#------------------------------------------------------------------------------------------------------
end
