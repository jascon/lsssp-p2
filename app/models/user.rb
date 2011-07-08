class User < ActiveRecord::Base
  belongs_to :role#, :counter_cache => true
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name,:email, :password, :password_confirmation, :remember_me,:role_id

# Students can register with service providers & service provider get his students(using inverse)
#-------------------------------------------------------------------------------------------------
  has_many :followings
  has_many :followers, :through => :followings
  #############         Inverse
  has_many :inverse_followings, :class_name => "Following", :foreign_key => "follower_id"
  has_many :inverse_followers, :through => :inverse_followings, :source => :user
#--------------------------------------------------------------------------------------------------

#Service Provider Registers with Certifications(to get certifications user.certifications) ..
#--------------------------------------------------------------------------------------------------
  has_many :certificate_providers
  has_many :certifications, :through => :certificate_providers
#--------------------------------------------------------------------------------------------------

# Validations
  validates :role_id,:presence=>true
#--------------------------------------------------------------------------------------------------

#Only Approved user can access the site
#--------------------------------------------------------------------------------------------------
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
##instance methods available for the user eg: current_user.students
#-------------------------------------------------------------------------------------------------
  def students( approved = 'all')
    if approved == 'yes'
      inverse_followers.where(:role_id=>4,:approved=>true)
    elsif approved == 'no'
      inverse_followers.where(:role_id=>4,:approved=>false)
    else
      inverse_followers.where(:role_id=>4)
    end
  end

  def assessors( approved = 'all')
    if approved == 'yes'
      inverse_followers.where(:role_id=>3,:approved=>true)
    elsif approved == 'no'
      inverse_followers.where(:role_id=>3,:approved=>false)
    else
      inverse_followers.where(:role_id=>3)
    end
  end
#----------------------------------------------------------------------------------------------------

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
      where(:role_id=>roleid,:approved=>true)
    end

  end
#------------------------------------------------------------------------------------------------------   


end
