Scoreupgolf::Application.routes.draw do
  root :to => 'portal/index#index'

  get "session/login"
  get "session/callback"
  get "session/destroy"

  namespace :portal do 
    get "index/index"
    get "friend/index"
    get "friend/search"
    get "friend/show"
  end

  namespace :competition do 
    get 'play/index'
    post 'play/view'
    get 'play/wait'
    get 'play/finish'

    get "arrange/index"
    post "arrange/confirm"
    post "arrange/finish"
  end

  namespace :service do
    get  "player_service/get_scores"
    post "player_service/set_score"
    get  "competition_service/get_holes"
    get  "competition_service/get_parties"
    get  "party_service/get_party_with_user"
    get  "user_service/search"
    get  "user_service/search_with_friendstate"
    get  "user_service/search_friend"
    get  "friend_service/apply"
    get  "friend_service/accept"
    get  "friend_service/cancel"
    get  "friend_service/deny"
    get  "golf_field_service/search"
    get  "golf_cource_service/get_cources"
  end

  namespace :scaffold do
    resources :competitions
    resources :users
    resources :players
    resources :parties
    resources :shot_results
    resources :golf_fields_greens
    resources :greens
    resources :golf_holes
    resources :golf_cources
    resources :golf_fields
  end

  # OmniAuth
  match "/auth/:provider/callback" => "session#callback"

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
