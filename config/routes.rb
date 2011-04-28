ActionController::Routing::Routes.draw do |map|

  map.root :controller => "home", :action => "index"
  map.connect 'polls/graph', :controller => 'polls', :action => 'graph'
  map.connect 'apartments/:id/recent_people', :controller => 'apartments', 
  :action => 'recent_people'


  map.resources :polls
  map.resources :users
  map.resources :lists
  map.resources :apartments

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'

  map.new_status 'apartments/new_status/:id', :controller => 'apartments', :action => 'new_status'
  map.apartment_callbacks 'apartments/:id/callbacks', :controller => 'apartments', :action => 
  'show_callbacks'
  map.callback_complete 'apartments/callback_complete/:id', :controller => 'apartments', :action => 
  'callback_complete'
  map.callback_uncomplete 'apartments/callback_uncomplete/:id', :controller => 'apartments', :action => 
  'callback_uncomplete'

  map.callback_mgmt_complete 'callbacks/callback_complete/:id', :controller =>
  'callbacks', :action => 'callback_complete'
  map.callback_mgmt_uncomplete 'callbacks/callback_uncomplete/:id', :controller =>
  'callbacks', :action => 'callback_uncomplete'

  map.add_user_to_list 'lists/:list_id/add_user_to_list/:user_id', :controller => 'lists', :action => 
  'add_user'
  map.remove_user_from_list 'lists/:list_id/remove_user_from_list/:user_id', :controller => 'lists', :action => 
  'remove_user'
  map.user_list_for_add 'lists/:id/user_listing', :controller => 'lists', :action => 
  'user_listing'
  map.new_list_message 'lists/:id/new_message', :controller => 'lists', :action => 
  'new_message'

  map.callbacks 'callbacks', :controller => 'callbacks', :action =>
  'callbacks'
  map.callbacks_outstanding 'callbacks/outstanding', :controller => 'callbacks', 
  :action => 'callbacks_outstanding'
  map.complete_all 'callbacks/complete_all', :controller => 'callbacks', 
  :action => 'complete_all'
  map.connect 'sms/process', :controller => 'SMS', :action =>
  'process_main'
  map.connect 'lists/:id/user_new', :controller => 'lists', :action => 'user_new'
  map.connect 'lists/:list_id/add_new_user_to_list', :controller => 'lists', :action => 'add_new_user'
  
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
