Cursusdienst::Application.routes.draw do

  get "test/index"

  get "pages/home"

  get "pages/about"

  get "pages/access_denied"

  get "pages/control_panel"

  resources :users do
		get :edit_permissions, :on => :member
		put :update_permissions, :on => :member
  end

  resources :sessions, :only => [:new, :create, :destroy]

  resources :institutes

  resources :faculties

  resources :disciplines

  resources :subjects

	resources :guilds do
		put :join, :on => :member
    put :update_filter, :on => :member
	end

  resources :options

  resources :materials do
		put :sell, :on => :member
		get :add_to_cart, :on => :member
  end

  resources :messages

  resources :permission_groups

  resources :filters do
    get :get_children_from_parent, :on => :collection
  end

  root :to => 'pages#home'

  match '/home', :to => 'pages#home'
  match '/about', :to => 'pages#about'
  match '/access_denied', :to => 'pages#access_denied'
  match '/control_panel', :to => 'pages#control_panel'
  match '/signup', :to => 'users#new'
  match '/register', :to => 'users#new'
  match '/signin', :to => 'sessions#new'
  match '/signout', :to => 'sessions#destroy'
  match '/logintest', :to => 'test#index'

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
  # match ':controller(/:action(/:id(.:format)))'
end
