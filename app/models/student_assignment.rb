class StudentAssignment < ActiveRecord::Base
  belongs_to :assignment
  belongs_to :assigner ,:class_name=>'User'
  belongs_to :owned_certification, :counter_cache => true
end
