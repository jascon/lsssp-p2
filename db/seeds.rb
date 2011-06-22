############ ROLES ################
Role.create(:name=>'super_admin')
Role.create(:name=>'admin')
Role.create(:name=>'student')
Role.create(:name=>'service_provider')
############### USERS #####################
super_admin = User.create(:email =>'superadmin@gmail.com', :password => "superadmin123", :password_confirmation => "superadmin123",:role_id=>1).confirm!
