require 'faker'
namespace :lsssp do
  task :setup  do
    Rake::Task["db:drop"].invoke
    Rake::Task["db:create"].invoke
    Rake::Task["db:migrate"].invoke
    make_roles
    make_users
    make_service_provider_students
    make_service_provider_accessors
    Rake::Task["db:seed"].invoke
  end
end

def make_roles
  Role.create(:name=>'Super Admin',:active=>1)
  Role.create(:name=>'Service Provider',:active=>1)
  Role.create(:name=>'Assessor',:active=>1)
  Role.create(:name=>'Student',:active=>1)

end

def make_users
  ############## Super Admin
  super_admin = User.create(:name=>'Super',:last_name=>'Admin',:email =>'superadmin@lsssp.org', :password => "superadmin123", :password_confirmation => "superadmin123",:role_id=>1,:primary_number=>9885976490).confirm!
  User.find(1).update_attribute('approved',true)
  ######### Service Providers ##############
  40.times do |n|
    name  = Faker::Name.first_name
    last_name = Faker::Name.last_name
    phone = Faker::PhoneNumber.phone_number
    enroll = '---'
    email = "service_provider#{n+1}@lsssp.org"
    password  = "password"
    User.create(:name=>name,:last_name=>last_name,:email =>email, :password =>password, :password_confirmation =>password,:role_id=>2,:approved=>1,:primary_number=>phone,:enrollment_no=>enroll).confirm!
  end
  ########### Accessors ######################
  40.times do |n|
    name  = Faker::Name.first_name
    last_name  = Faker::Name.last_name
    phone = Faker::PhoneNumber.phone_number
    enroll = '---'
    email = "assessor#{n+1}@lsssp.org"
    password  = "password"
    User.create(:name=>name ,:last_name=>last_name,:email =>email, :password =>password, :password_confirmation =>password,:role_id=>3,:approved=>1,:primary_number=>phone,:enrollment_no=>enroll).confirm!
  end
  ########### Students ######################
  40.times do |n|
    name  = Faker::Name.first_name
    last_name  = Faker::Name.last_name
    phone = Faker::PhoneNumber.phone_number
    enroll = rand(10_000_000_000-1_000_000_000) + 1_000_000_000
    email = "student#{n+1}@lsssp.org"
    password  = "password"
    User.create(:name=>name ,:last_name=>last_name,:email =>email, :password =>password, :password_confirmation =>password,:role_id=>4,:approved=>1,:primary_number=>phone,:enrollment_no=>enroll).confirm!
  end
end
####### Register Students with Service Providers
def make_service_provider_students
  ## Creating Many Service Providers for single user(student)
  service_providers = User.where(:role_id=>2).limit(20)
  student =  User.where(:role_id=>4).first
  service_providers.each { |service_provider| Following.create(:user_id=>student.id,:follower_id=>service_provider.id) }

  ## Creating Many Students for single user(Service Provider)
  students = User.where(:role_id=>4).order('created_at DESC').limit(20)
  service_provider = User.where(:role_id=>2).first
  students.each { |student| Following.create(:user_id=>student.id,:follower_id=>service_provider.id) }
end
####### Register Accessors with Service Providers

def make_service_provider_accessors
  ## Creating Many Service Providers for single user(accessor)
  service_providers = User.where(:role_id=>2).limit(20)
  accessor =  User.where(:role_id=>3).first
  service_providers.each { |service_provider| Following.create(:user_id=>accessor.id,:follower_id=>service_provider.id) }

  ## Creating Many accessors for single user(Service Provider)
  accessors = User.where(:role_id=>3).order('created_at DESC').limit(20)
  service_provider = User.where(:role_id=>2).first
  accessors.each { |accessors| Following.create(:user_id=>accessors.id,:follower_id=>service_provider.id) }
end
