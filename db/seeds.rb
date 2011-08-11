Topic.create(:name=>'Java',:active=>1)
Topic.create(:name=>'Ruby on Rails',:active=>1)

Subtopic.create(:topic_id=>1,:name=>'Core Java',:active=>1)
Subtopic.create(:topic_id=>1,:name=>'Advanced Java',:active=>1)
Subtopic.create(:topic_id=>1,:name=>'J2EE',:active=>1)

Subtopic.create(:topic_id=>2,:name=>'Ruby',:active=>1)
Subtopic.create(:topic_id=>2,:name=>'Rails',:active=>1)


Certification.create(:topic_id=>1,:name=>'Java Certification',:price=>200,:active=>1,:duration=>10,:no_of_questions=>10,
                    :positive_marks=>1,:negative_marks=>0,:unattempted_marks=>0,:pass_marks_percentage=>50)

Certification.create(:topic_id=>2,:name=>'Ruby on Rails Certification',:price=>300,:active=>1,:duration=>10,:no_of_questions=>10,
                    :positive_marks=>1,:negative_marks=>0,:unattempted_marks=>0,:pass_marks_percentage=>50)


=begin
############ ROLES ################
Role.create(:name=>'Super Admin')
Role.create(:name=>'Service Provider')
Role.create(:name=>'Student')
Role.create(:name=>'Accessor')
############### USERS #####################
##Super Admins
super_admin = User.create(:email =>'superadmin@lsssp.org', :password => "superadmin123", :password_confirmation => "superadmin123",:role_id=>1).confirm!
User.find(1).update_attribute('approved',true)
User.create(:email =>'superadmin2@lsssp.org', :password => "superadmin123", :password_confirmation => "superadmin123",:role_id=>1).confirm!
## Service Providers
User.create(:email =>'service_provider1@lsssp.org', :password => "123456", :password_confirmation => "123456",:role_id=>2).confirm!
User.create(:email =>'service_provider2@lsssp.org', :password => "123456", :password_confirmation => "123456",:role_id=>2)
User.create(:email =>'service_provider3@lsssp.org', :password => "123456", :password_confirmation => "123456",:role_id=>2)
## Students
User.create(:email =>'student1@lsssp.org', :password => "123456", :password_confirmation => "123456",:role_id=>3).confirm!
User.create(:email =>'student2@lsssp.org', :password => "123456", :password_confirmation => "123456",:role_id=>3)
User.create(:email =>'student3@lsssp.org', :password => "123456", :password_confirmation => "123456",:role_id=>3)
###### Accessors
User.create(:email =>'accessor1@lsssp.org', :password => "123456", :password_confirmation => "123456",:role_id=>4).confirm!
User.create(:email =>'accessor2@lsssp.org', :password => "123456", :password_confirmation => "123456",:role_id=>4)
User.create(:email =>'accessor3@lsssp.org', :password => "123456", :password_confirmation => "123456",:role_id=>4)
=end

