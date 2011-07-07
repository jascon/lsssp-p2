class Certification < ActiveRecord::Base
  attr_accessible :topic_id,:name, :description, :active

# Associations
#-------------------------------------------------------------------------------------------------------
  belongs_to :topic, :conditions =>{:active => true }
  has_one :examination,:dependent=>:destroy

  has_many :certificate_providers
  has_many :users, :through => :certificate_providers
#------------------------------------------------------------------------------------------------------

  accepts_nested_attributes_for :examination, :allow_destroy => true#,:reject_if => proc { |att| att['name'] == '0' },:allow_destroy => true

# START --> Validations
  #------------------------------------------------------------------------------------------------------
  validates :topic_id,:presence => true
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