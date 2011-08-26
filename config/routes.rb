LssspP2::Application.routes.draw do



  get "user_info/index"

  devise_for :users, :path_names => { :sign_up => "register" }
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
      get 'approve',:on=>:member
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
      get 'export',:on=>:collection
    end
  end



  #--------------------------------------------------------------------------
  #Student namespace
  #--------------------------------------------------------------------------
  namespace :student do
    resources :service_providers do
      get 'my_service_providers',:on=>:collection
    end
    resources :certifications , :only => [:index] do
      get 'assignments' ,:on=>:member
    end
    #resource :exam
  end
  ######## Exam
  match "exam/:id/:status" => "student/exam#index",:as=>:exam
  match "active_question"  => "student/exam#active_question",:as=>:active_question
  match "update_answer" => "student/exam#update_answer"
  match "finish_exam/:id" => "student/exam#finish_exam" ,:as=>:finish_exam
  match "review_question" => "student/exam#review_question"
  #--------------------------------------------------------------------------
  #Service Provider Namespace
  #--------------------------------------------------------------------------
  namespace :service_provider do
    resources :certifications do
      get 'my_certifications',:on=>:collection
      get 'export',:on=>:collection
    end
    resources :assessors,:students  do
      get 'approve',:on=>:member
      get 'export',:on=>:collection
      get 'students',:on=>:member
    end
  end
  #--------------------------------------------------------------------------
  namespace :assessor do
    resources :assignments
    resources :students, :only => [:index] do
      get 'manage_assignments' ,:on=>:collection
      post 'manage_assignments' ,:on=>:collection

      get 'pending_assignments' ,:on=>:collection
      post 'pending_assignments' ,:on=>:collection

      post 'assign_assignments',:on=>:collection

    end
  end


#namespace(:assessor){ resources :assignments }
#----------------------------------------------------------------------------
namespace :catalog do
  resources :topics,:subtopics,:questions do
    get 'active' ,:on=>:member
    get 'export',:on=>:collection
  end
  resources :certifications do
    get 'active' ,:on=>:member
    get 'export',:on=>:collection
    get 'load_subtopics' ,:on=>:collection
  end
end
resources :payment_gateways do
  get 'active' ,:on=>:member
end
#match "certifications/purchased" => "certification/exams#purchased",:as=>:certifications_purchased
match "certifications/purchased" => "certifications#index",:as=>:certifications_purchased
match "certification/purchased" => "certifications#purchased_certification"#,:as=>:purchased_certification
match "certifications/exams"  =>"certifications#exams"

match "manage_certifications" =>"certifications#manage_certifications"



match "user_info/:id" => "user_info#index" ,:as=>:user_info
# The priority is based upon order of creation:
# first created -> highest priority.

# Sample of regular route:
#   match 'products/:id' => 'catalog#view'
# Keep in mind you can assign values other than :controller and :action

# Sample of named route:
#   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
# This route can be invoked with purchase_url(:id => product.id)

# Sample resource route (maps HTTP verbs to controller actions automatically):
#   resources :products

# Sample resource route with options:
#   resources :products do
#     member do
#       get 'short'
#       post 'toggle'
#     end
#
#     collection do
#       get 'sold'
#     end
#   end

# Sample resource route with sub-resources:
#   resources :products do
#     resources :comments, :sales
#     resource :seller
#   end

# Sample resource route with more complex sub-resources
#   resources :products do
#     resources :comments
#     resources :sales do
#       get 'recent', :on => :collection
#     end
#   end

# Sample resource route within a namespace:
#   namespace :admin do
#     # Directs /admin/products/* to Admin::ProductsController
#     # (app/controllers/admin/products_controller.rb)
#     resources :products
#   end

# You can have the root of your site routed with "root"
# just remember to delete public/index.html.
root :to => "home#index"

# See how all your routes lay out with "rake routes"

# This is a legacy wild controller route that's not recommended for RESTful applications.
# Note: This route will make all actions in every controller accessible via GET requests.
match ':controller(/:action(/:id(.:format)))'
end
