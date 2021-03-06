Untitled2::Application.routes.draw do
  # resources :tasks do
  #   member do
  #     get :done, :archive
  #   end
  # end


  resources :tasks, only: [:create, :done]
  resources :sessions, only: [:new, :create, :destroy]
  resources :users

  root to: 'tasks#home'

  match '/help',    to: 'static_pages#help'
  match '/about',   to: 'static_pages#about'
  match '/contact', to: 'static_pages#contact'
  match '/signup',  to: 'users#new'
  match '/signin',  to: 'sessions#new'
  match '/sessions',  to: 'sessions#create'
  match '/signout', to: 'sessions#destroy', via: :delete

  # match '/tasks/done', to: 'tasks#done'
  # match '/tasks/archive', to: 'tasks#archive'
  match '/tasks', to: 'tasks#all_tasks'

  match '/api/get-email', to: 'users#get_regex_emails'

  match '/tasks/:tag', :to => 'tasks#home', via: :get
  # match '/tasks/:action_type', :to => 'tasks#update', via: :get


  match '/tasks/mark-as-done', to: 'tasks#mark_as_done'
  match '/tasks/mark-as-archive', to: 'tasks#mark_as_archive'

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
