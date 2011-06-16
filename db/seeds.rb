super_admin = User.create(:email =>'superadmin@gmail.com', :password => "superadmin123", :password_confirmation => "superadmin123",:role=>'super_admin').confirm!
