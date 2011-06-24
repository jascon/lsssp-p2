class Permission < ActiveRecord::Base  
  belongs_to :authorization,:include => :role
#validations
#-------------------------------------------------------------------------
validates :name,:presence=>true, :uniqueness =>{:scope=>:authorization_id}, :length => { :maximum => 25}
#-------------------------------------------------------------------------  
end
