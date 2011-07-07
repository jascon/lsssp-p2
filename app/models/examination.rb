class Examination < ActiveRecord::Base
   attr_accessible :certification_id,:name, :duration, :positive_marks,:negative_marks,:unattempted_marks,:pass_marks_percentage
   belongs_to :certification
end
