class StudentAssignment < ActiveRecord::Base
  belongs_to :assignment
  belongs_to :assigner ,:class_name=>'User'
  belongs_to :owned_certification, :counter_cache => true

  #has_one :completed_assignment
  has_many :completed_attachments

  accepts_nested_attributes_for :completed_attachments, :allow_destroy => true  ,:reject_if => proc { |att| att['hanger'].nil? }

end
