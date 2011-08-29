class CompletedAttachment < ActiveRecord::Base
  belongs_to :student_assignment
  belongs_to :attachment
  has_attached_file :hanger
end
