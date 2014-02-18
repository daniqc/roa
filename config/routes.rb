Roa::Application.routes.draw do
  get 'signup', to: 'people#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  get 'upload_material', to: 'learning_objects#upload_material', as: 'upload_material'
  get 'course_organization', to: 'courses#course_organization', as: 'course_organization'
  get 'methodologies', to: 'application#help_methodologies', as: 'methodologies'
  get 'aoddei', to: 'application#aoddei', as: 'aoddei'
  post 'unzip_lo', to: 'learning_objects#unzip_lo', as: 'unzip_lo'
  post 'new_material', to: 'learning_objects#new_material', as: 'new_material'

  resources :users
  resources :people
  resources :sessions
  resources :schedules
  resources :class_schedules
  resources :course_classes
  resources :roles
  resources :metadata_schemas
  resources :lo_metadata_schemas
  resources :learning_materials
  

  resources :courses, :shallow => true do
    resources :subtopics, :controller => 'contents', :type => 'Subtopic'
    resources :topics, :controller => 'contents', :type => 'Topic'
    resources :participants
  end 

  resources :learning_objects, :shallow => true do
    resources :organizations, :shallow => true do
      resources :items
    end
    resources :resources, :shallow => true do
      resources :resource_files
    end
    resources :comments
    resources :ratings
  end



  root :to => 'dashboard#index'
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
  # root :to => 'workspace#courses'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
