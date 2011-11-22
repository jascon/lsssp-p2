class User < ActiveRecord::Base
  belongs_to :role#, :counter_cache => true
                  # Include default devise modules. Others available are:
                  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name,:email, :password, :password_confirmation, :remember_me,:role_id,:follower_ids ,:last_name
  attr_accessible :enrollment_no,:approved,:primary_number,:secondary_number
  attr_accessible :avatar

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>",:small => "25x25>" }
#  accepts_nested_attributes_for :user_profile
  has_one :user_profile
# Students can register with service providers & service provider get his students(using inverse)
#-------------------------------------------------------------------------------------------------
  has_many :followings
  has_many :followers, :through => :followings
#############         Inverse
  has_many :inverse_followings, :class_name => "Following", :foreign_key => "follower_id"
  has_many :inverse_followers, :through => :inverse_followings, :source => :user
#--------------------------------------------------------------------------------------------------

# user.provided_certifications(get all certifications registered by service provider)
#--------------------------------------------------------------------------------------------------
  has_many :certificate_providers, :foreign_key => "provider_id"
  has_many :provided_certifications,:source=>:certification, :through=>:certificate_providers

# user.owned(to get all certifications owned by student)
#--------------------------------------------------------------------------------------------------
  has_many :owned_certifications, :foreign_key => "owned_id"
  has_many :owned,:source=>:certification, :through=>:owned_certifications

#--------------------------------------------------------------------------------------------------
  has_many :student_exams
  has_many :assignments


# Validations
  validates :role_id,:presence=>true
  validates :email,:presence => true
  validates :name,:presence => true
  validates :primary_number,:presence => true
  validates :last_name, :presence=>true

#  validates :last_name,:presence => true
#  validates :password, :presence => true
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

  def following_assessors
    followers.where(:role_id=>3,:approved=>true)
  end

  def following_service_providers
    followers.where(:role_id=>2,:approved=>true)
  end

#----------------------------------------------------------------------------------------------------

# Class Methods
#Scopes are dead in Rails3(from ref: http://www.railway.at/2010/03/09/named-scopes-are-dead/)
#So use class methods instead
#------------------------------------------------------------------------------------------------------      
  class << self
    def search(query,me,roleid)
      if !query.nil? and !roleid.blank?
        except_me(me).where({:name.matches => "%#{query}%"} | {:email.matches => "%#{query}"} | {:last_name.matches => "%#{query}"} | {:enrollment_no.matches => "%#{query}"}| {:primary_number.matches => "%#{query}"}| {:secondary_number.matches => "%#{query}"}).with_role(roleid) #from meta_where gem
      elsif !query.nil?
        except_me(me).where({:name.matches => "%#{query}%"} | {:email.matches => "%#{query}"} | {:last_name.matches =>"%#{query}"}| {:enrollment_no.matches => "%#{query}"}| {:primary_number.matches => "%#{query}"}| {:secondary_number.matches => "%#{query}"} )
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
      where(:role_id=>roleid)#,:approved=>true)
    end

  end
#------------------------------------------------------------------------------------------------------   
  def recent
    order('created_at DESC').limit(4)
  end


end
