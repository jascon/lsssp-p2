class Assignment < ActiveRecord::Base
  #attr_accessible :name, :description
  belongs_to :certification
  belongs_to :user
  has_many :attachments
  accepts_nested_attributes_for :attachments, :allow_destroy => true

  validates :certification_id,:user_id,:presence=>true
end
