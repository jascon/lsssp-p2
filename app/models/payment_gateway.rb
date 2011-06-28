class PaymentGateway < ActiveRecord::Base
  attr_accessible :api_name, :url, :username, :password, :active
  # START --> Validations 
#------------------------------------------------------------------------------------------------------
  validates :api_name,:presence=>true, :uniqueness => true, :length => { :maximum => 50}
  validates :username,:password,:presence=>true, :length => { :maximum => 25}
  validates :url,:presence=>true, :length => { :maximum => 2000}
  
#------------------------------------------------------------------------------------------------------

# Class Methods
#Scopes are dead in Rails3(from ref: http://www.railway.at/2010/03/09/named-scopes-are-dead/)
#So use class methods instead
#------------------------------------------------------------------------------------------------------      
  class << self
    def search(query)
      if query
        where(:api_name.matches => "%#{query}%") #from meta_where gem
      else
       scoped
      end
    end
    def recent
      order('created_at DESC').limit(4)
    end
  end
#------------------------------------------------------------------------------------------------------  
end
