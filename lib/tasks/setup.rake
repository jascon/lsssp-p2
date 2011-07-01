require 'faker'
namespace :lsssp do
  task :setup  do
    Rake::Task["db:drop"].invoke
    Rake::Task["db:create"].invoke
    Rake::Task["db:migrate"].invoke
   # Rake::Task["db:seed"].invoke
    make_roles
    make_users
  end
end

def make_roles
  Role.create(:name=>'Super Admin')
  Role.create(:name=>'Service Provider')
  Role.create(:name=>'Accessor')
  Role.create(:name=>'Student')

end

def make_users
############## Supera Admin
   super_admin = User.create(:name=>'bla bla',:email =>'superadmin@lsssp.org', :password => "superadmin123", :password_confirmation => "superadmin123",:role_id=>1).confirm!
   User.find(1).update_attribute('approved',true)
######### Service Providers ##############
   50.times do |n|
    name  = Faker::Name.name
    email = "service_provider#{n+1}@lsssp.org"
    password  = "password"
    User.create(:name=>name ,:email =>email, :password =>password, :password_confirmation =>password,:role_id=>2).confirm!
   end
 ########### Accessors ######################
  50.times do |n|
    name  = Faker::Name.name
    email = "accessor#{n+1}@lsssp.org"
    password  = "password"
    User.create(:name=>name ,:email =>email, :password =>password, :password_confirmation =>password,:role_id=>3).confirm!
  end
  ########### Students ######################
  50.times do |n|
    name  = Faker::Name.name
    email = "student#{n+1}@lsssp.org"
    password  = "password"
    User.create(:name=>name ,:email =>email, :password =>password, :password_confirmation =>password,:role_id=>3).confirm!
   end


end
