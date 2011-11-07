LssspP2::Application.routes.draw do
  resources :coupons
  resources :verifications

  get "user_info/index"
  devise_for :users, :path_names => {:sign_up => "register"}
=begin
devise_for :users, :as => "", :path_names => { :sign_in => "login", :sign_out => "logout", :sign_up => "register" }
match "login" => "devise/sessions#new", :as => :new_user_session
match "logout" => "devise/sessions#destroy", :as => :destroy_user_session
match "register" => "devise/registrations#new", :as => :new_user_registration
=end
  resources :followings

  #Superadmin Namespace
  #--------------------------------------------------------------------------
  namespace :super_admin do
    resources :users do
      get 'approve', :on=>:member
      get 'profile', :on=>:member
      get 'upload', :on=>:collection
      get 'export', :on=>:collection
      get 'reset', :on=>:member
      post 'csv_import',:on=>:collection
    end
    #---------------------------------------------------------------------------
    # ROles
    #---------------------------------------------------------------------------
    resources :roles do
      member do
        get 'permissions'
        put 'assign_permissions'
        get 'active'
      end
      get 'export', :on=>:collection
    end
  end
  #--------------------------------------------------------------------------
  #Student namespace
  #--------------------------------------------------------------------------
  namespace :student do
    resources :service_providers do
      get 'my_service_providers', :on=>:collection
      post 'coupon_check',:on=>:collection
    end
    resources :certifications, :only => [:index] do
      get 'assignments', :on=>:member
      get 'download', :on=>:member
      get 'assign',:on=>:member
      get 'subscribe', :on=>:member
    end
    #resource :exam
  end
  ######## Exam
  match "exam/:id/:status" => "student/exam#index", :as=>:exam
  match "active_question" => "student/exam#active_question", :as=>:active_question
  match "update_answer" => "student/exam#update_answer"
  match "finish_exam/:id" => "student/exam#finish_exam", :as=>:finish_exam

  match "save_exam/:id" => "student/exam#save_exam", :as=>:save_exam

  match "review_question" => "student/exam#review_question"

  ###### Subscribe/Unsubscribe exam for user from super_admin
  match "/:name/:id/subscribe_to/:provider_id"=>"student/certifications#subscribe",:as=>:subscribe_certification
  match "/:id/un_subscribe"=>"student/certifications#un_subscribe",:as=>:un_subscribe_certification

  #--------------------------------------------------------------------------
  #Service Provider Namespace
  #--------------------------------------------------------------------------
  namespace :service_provider do
    resources :certifications do
      get 'my_certifications', :on=>:collection
      get 'export', :on=>:collection
    end
    resources :assessors, :students do
      get 'approve', :on=>:member
      get 'export', :on=>:collection
      get 'students', :on=>:member
    end
  end
  #--------------------------------------------------------------------------
  namespace :assessor do
    resources :assignments
    resources :students, :only => [:index] do
      get 'manage_assignments', :on=>:collection
      post 'manage_assignments', :on=>:collection
      get 'pending_assignments', :on=>:collection
      post 'pending_assignments', :on=>:collection
      post 'assign_assignments', :on=>:collection
      get 'assignments', :on=>:member
      get 'download', :on=>:member
      #  post 'update_assignment_result' ,:on=>:member
    end
  end
  #namespace(:assessor){ resources :assignments }
  #----------------------------------------------------------------------------
  namespace :catalog do
    resources :topics, :subtopics do
      get 'active', :on=>:member
      get 'export', :on=>:collection

    end
    resources :certifications do
      get 'active', :on=>:member
      get 'export', :on=>:collection
      get 'load_subtopics', :on=>:collection
    end
    resources :questions do
      get 'active',:on=>:member
      get 'export',:on=>:collection
     end
  end

  resources :payment_gateways do
    get 'active', :on=>:member
  end

  #match "certifications/purchased" => "certification/exams#purchased",:as=>:certifications_purchased
  match "certifications/purchased" => "certifications#index", :as=>:certifications_purchased
  match "certification/purchased" => "certifications#purchased_certification" #,:as=>:purchased_certification
  match "certifications/exams" =>"certifications#exams"
  match "manage_certifications" =>"certifications#manage_certifications"
  match "user_info/:id" => "user_info#index", :as=>:user_info
  match "certifications/purchased/:id/edit_score" => "certifications#edit_score", :as=>:edit_score
  match "certifications/purchased/:id/update_score" => "certifications#update_score", :as=>:update_score

  root :to => "home#index"

# Note: This route will make all actions in every controller accessible via GET requests.
  match ':controller(/:action(/:id(.:format)))'
end
