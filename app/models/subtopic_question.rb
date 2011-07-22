class SubtopicQuestion < ActiveRecord::Base
  belongs_to :certification
  belongs_to :subtopic
  #validates :certification_id,:subtopic_id,:presence => true
end
