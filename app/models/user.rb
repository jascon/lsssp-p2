class User < ActiveRecord::Base
  belongs_to :role#, :counter_cache => true
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name,:email, :password, :password_confirmation, :remember_me,:role_id
  
  validates :role_id,:presence=>true
  
  def active_for_authentication? 
   super && approved? 
  end 

  def inactive_message 
    if !approved? 
     :not_approved 
   else 
    super # Use whatever other message 
   end 
 end
  
# Class Methods
#Scopes are dead in Rails3(from ref: http://www.railway.at/2010/03/09/named-scopes-are-dead/)
#So use class methods instead
#------------------------------------------------------------------------------------------------------      
  class << self
    def search(query,me,roleid)
      if !query.nil? & !roleid.nil?
        except_me(me).where(:email.matches => "%#{query}%" ).with_role(roleid) #from meta_where gem
      elsif !query.nil?
       except_me(me).where(:email.matches => "%#{query}%" )
      elsif !roleid.nil?
        except_me(me).with_role(roleid)
      else
       except_me(me)
      end
    end
    def except_me(me)
      where('id != ?', me.id)
    end
    def with_role(roleid)
      where(:role_id=>roleid)
    end
  end
#------------------------------------------------------------------------------------------------------   

  
end
