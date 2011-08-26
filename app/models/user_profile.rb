class UserProfile < ActiveRecord::Base

  belongs_to :user

  #Avatar
  has_attached_file :avatar, :styles => {:medium => "300x300>", :thumb => "100x100>", :small=>"50x50"}

end
