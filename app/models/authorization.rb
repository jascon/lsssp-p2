class Authorization < ActiveRecord::Base
  belongs_to :role#, :counter_cache => true
  has_many :permissions,:dependent=>:destroy
  accepts_nested_attributes_for :permissions, :allow_destroy => true
  
# Validations
#----------------------------------------------------------------------------
  validates :name,:presence=>true, :uniqueness =>{:scope=>:role_id}, :length => { :maximum => 25}
#----------------------------------------------------------------------------
end
