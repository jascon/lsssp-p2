class Following < ActiveRecord::Base
  belongs_to :user
  belongs_to :follower, :class_name => 'User'

# Validations
#----------------------------------------------------------------------------
  validates :user_id,:presence=> true, :uniqueness =>{:scope=>:follower_id}
  validates :follower_id,:presence=> true
#----------------------------------------------------------------------------

end
