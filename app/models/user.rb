class User < ActiveRecord::Base
  belongs_to :role#, :counter_cache => true
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,:role_id
  
  validates :role_id,:presence=>true
  
# Class Methods
#Scopes are dead in Rails3(from ref: http://www.railway.at/2010/03/09/named-scopes-are-dead/)
#So use class methods instead
#------------------------------------------------------------------------------------------------------      
  class << self
    def search(query)
      if query
        where(:email.matches => "%#{query}%") #from meta_where gem
      else
       scoped
      end
    end    
  end
#------------------------------------------------------------------------------------------------------   

  
end
