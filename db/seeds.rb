############ ROLES ################
Role.create(:name=>'Super Admin')
Role.create(:name=>'Service Provider')
#Role.create(:name=>'admin')
#Role.create(:name=>'student')
#Role.create(:name=>'service_provider')
############### USERS #####################
super_admin = User.create(:email =>'superadmin@lsssp.org', :password => "superadmin123", :password_confirmation => "superadmin123",:role_id=>1,:approved=>true).confirm!
