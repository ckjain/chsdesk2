ChsdeskSorcery::Application.routes.draw do
  root :to => 'users#index'
    
  resources :users, :admins do
    collection do
      get :login_from_http_basic
    end
    member do
      get :activate
    end
  end
  
  resources :user_sessions
  resources :password_resets
  
  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout
  
  resource :oauth do
    get :callback
  end
  match "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider

  resources :meetings do
      resources :agendas
      resources :meeting_members
      resources :meeting_types
  end

  resources :bills do
      resources :bill_headers
      resources :bill_setups
  end

  resources :pages
  resources :societies do
      resources :vendors
      resources :staffs
    resources :member_properties do
      resources :units do
        resources :unit_types
      end
      resources :members do
        resources :committee_members
      end
    end
   end
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action




  match '/master',      :to => 'societies#index'
  match '/billing',     :to => 'bills#index'
  match '/billsetup',   :to => 'bill_setups#index'
  match '/billdetail',  :to => 'bill_headers#index'
  match '/contact',     :to => 'pages#contact'
  match '/about',       :to => 'pages#about'
  match '/help',        :to => 'pages#help'
  match '/home',        :to => 'pages#home'
  match '/units',   :to => 'units#index'
  match '/unit_types',  :to => 'unit_types#index'
  match '/committee_members',  :to => 'committee_members#index'
  match '/staffs',      :to => 'staffs#index'
  match '/members',     :to => 'members#index'
  match '/meetings',     :to => 'meetings#index'
  match '/vendors',     :to => 'vendors#index'

  netzke

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
