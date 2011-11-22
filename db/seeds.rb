Topic.create(:name=>'Lean Practitioner',:active=>1)
Topic.create(:name=>'Six Sigma Green Belt',:active=>1)

Subtopic.create(:topic_id=>1,:name=>'Lean-Basic',:active=>1)
Subtopic.create(:topic_id=>1,:name=>'Lean-Advance',:active=>1)

Subtopic.create(:topic_id=>2,:name=>'SSGB-Basic',:active=>1)
Subtopic.create(:topic_id=>2,:name=>'SSGB-Advance',:active=>1)


=begin
Certification.create(:topic_id=>1,:name=>'Lean Practitioner',:price=>200,:active=>1,:duration=>10,:no_of_questions=>10,
                    :positive_marks=>1,:negative_marks=>0,:unattempted_marks=>0,:pass_marks_percentage=>50)

Certification.create(:topic_id=>2,:name=>'Six Sigma Green Belt',:price=>300,:active=>1,:duration=>10,:no_of_questions=>10,
                    :positive_marks=>1,:negative_marks=>0,:unattempted_marks=>0,:pass_marks_percentage=>50)


SubtopicQuestion.create(:certification_id=>1,:subtopic_id=>1,:total_questions=>5)
SubtopicQuestion.create(:certification_id=>1,:subtopic_id=>2,:total_questions=>5)
SubtopicQuestion.create(:certification_id=>2,:subtopic_id=>1,:total_questions=>5)
SubtopicQuestion.create(:certification_id=>2,:subtopic_id=>2,:total_questions=>5)
=end
