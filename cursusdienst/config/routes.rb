require 'subdomain'

Cursusdienst::Application.routes.draw do

  get "test/index"

  get "pages/home"

  get "pages/about"

  get "pages/access_denied"

  get "pages/control_panel"

  get "pages/manual"

  get "attachments/download"

  resources :users do
    get :edit_permissions, :on => :member
    put :update_permissions, :on => :member
  end

  resources :sessions, :only => [:new, :create, :destroy]

  resources :institutes

  resources :action_logs, :only => [:index]

  resources :stocks

  resources :printers

  resources :price_sets

  resources :prices

  resources :ratings

  resources :results do
    get :per_guild, :on => :collection
    get :per_isntitute, :on => :collection
    get :per_discipline, :on => :collection
    get :per_year, :on => :collection
    get :per_subject, :on => :collection
  end

  resources :info_strings

  resources :supplies, :only => [:new, :create, :edit, :update, :destroy]

  resources :orders do
    put :mark_as_payed, :on => :member
    get :logs, :on => :collection
    get :results, :on => :collection
    get :my_orders, :on => :collection
    put :search, :on => :collection
  end

  resources :print_jobs do
    get :logs, :on => :collection
  end

  resources :shopping_cart_items do
    put :add, :on => :member
    put :substract, :on => :member
  end

  resources :faculties

  resources :disciplines

  resources :subjects

  constraints(Subdomain) do
    match '/' => 'guilds#show'
  end

  resources :guilds do
    put :join, :on => :member
    put :update_filter, :on => :member
    get :news, :on => :member
  end



  resources :options

  resources :materials do
    put :sell, :on => :member
    get :add_to_cart, :on => :member
    get :add_to_supply, :on => :member
  end

  resources :messages

  resources :permission_groups

  resources :filters do
    get :get_children_from_parent, :on => :collection
  end

  root :to => 'pages#home'

  match '/home', :to => 'pages#home'
  match '/manual', :to => 'pages#manual'
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
