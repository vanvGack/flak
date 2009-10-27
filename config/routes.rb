ActionController::Routing::Routes.draw do |map|
  map.resources :users, :only => [:index, :create], :collection => { :current => :get, :prune => :get }
  map.resource  :session, :only => [:create, :destroy]
  map.resources :messages, :only => [:index, :create]
end
