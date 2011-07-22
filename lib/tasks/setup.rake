require 'faker'
namespace :lsssp do
  task :setup  do
    Rake::Task["db:drop"].invoke
    Rake::Task["db:create"].invoke
    Rake::Task["db:migrate"].invoke
    # Rake::Task["db:seed"].invoke
    make_roles
    make_users
    make_service_provider_students
    make_service_provider_accessors
  end
end

def make_roles
  Role.create(:name=>'Super Admin')
  Role.create(:name=>'Service Provider')
  Role.create(:name=>'Assessor')
  Role.create(:name=>'Student')

end

def make_users
  ############## Supera Admin
  super_admin = User.create(:name=>'bla bla',:email =>'superadmin@lsssp.org', :password => "superadmin123", :password_confirmation => "superadmin123",:role_id=>1).confirm!
  User.find(1).update_attribute('approved',true)
  ######### Service Providers ##############
  30.times do |n|
    name  = Faker::Name.name
    email = "service_provider#{n+1}@lsssp.org"
    password  = "password"
    User.create(:name=>name ,:email =>email, :password =>password, :password_confirmation =>password,:role_id=>2,:approved=>1).confirm!
  end
  ########### Accessors ######################
  30.times do |n|
    name  = Faker::Name.name
    email = "accessor#{n+1}@lsssp.org"
    password  = "password"
    User.create(:name=>name ,:email =>email, :password =>password, :password_confirmation =>password,:role_id=>3,:approved=>1).confirm!
  end
  ########### Students ######################
  30.times do |n|
    name  = Faker::Name.name
    email = "student#{n+1}@lsssp.org"
    password  = "password"
    User.create(:name=>name ,:email =>email, :password =>password, :password_confirmation =>password,:role_id=>4,:approved=>1).confirm!
  end
end
####### Register Students with Service Providers

def make_service_provider_students
  ## Creating Many Service Providers for single user(student)
  service_providers = User.where(:role_id=>2).limit(10)
  student =  User.where(:role_id=>4).first
  service_providers.each { |service_provider| Following.create(:user_id=>student.id,:follower_id=>service_provider.id) }

  ## Creating Many Students for single user(Service Provider)
  students = User.where(:role_id=>4).order('created_at DESC').limit(10)
  service_provider = User.where(:role_id=>2).first
  students.each { |student| Following.create(:user_id=>student.id,:follower_id=>service_provider.id) }
end



####### Register Accessors with Service Providers

def make_service_provider_accessors
  ## Creating Many Service Providers for single user(accessor)
  service_providers = User.where(:role_id=>2).limit(10)
  accessor =  User.where(:role_id=>3).first
  service_providers.each { |service_provider| Following.create(:user_id=>accessor.id,:follower_id=>service_provider.id) }

  ## Creating Many accessors for single user(Service Provider)
  accessors = User.where(:role_id=>34).order('created_at DESC').limit(10)
  service_provider = User.where(:role_id=>2).first
  accessors.each { |accessors| Following.create(:user_id=>accessors.id,:follower_id=>service_provider.id) }
end
