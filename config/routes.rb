Rails.application.routes.draw do
  get 'invitations/new'

  get 'sessions/new'

  get 'users/new'

  root 'static_pages#home'
  get 'help' => 'static_pages#help'
  get 'about' => 'static_pages#about'
  get 'contact' => 'static_pages#contact'
  get 'newuser' => 'users#new'
  get    'login'   => 'sessions#new'
  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  resources :users
  resources :events
  resources :invitations
  
  #user API routes
  get 'api/users' => 'api_users#find'
  get 'api/users/me' => 'api_users#current'
  post 'api/users/authenticate' => 'api_users#create_authentication_token'
  get 'api/users/authenticate' => 'api_users#get_authentication_token'
  post 'api/users' => 'api_users#new'
  patch 'api/users' => 'api_users#update'
  delete 'api/users' => 'api_users#destroy'
  
  #event API routes
  get 'api/events' => 'api_events#find'
  post 'api/events' => 'api_events#new'
  patch 'api/events' => 'api_events#update'
  delete 'api/events' => 'api_events#destroy'
  get 'api/events/all' => 'api_events#all'
  
  #invitation API routes
  post 'api/invitations' => 'api_invitations#new'
  post 'api/invitations/toggle' => 'api_invitations#toggle'
  get 'api/invitations/event' => 'api_invitations#show'
  get 'api/invitations' => 'api_invitations#mine'
  delete 'api/invitations' => 'api_invitations#destroy'
  get 'api/events/invited/' => 'api_invitations#show_events'
  get 'api/invitations/accepted' => 'api_invitations#my_accepted'
  
  #message API routes
  get 'api/messages' => 'api_messages#show'
  post 'api/messages' => 'api_messages#new'
  

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
