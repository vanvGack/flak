ActionController::Routing::Routes.draw do |map|
  map.resources :users, :only => [:index, :create, :current], :collection => { :current => :get }
  map.resource  :session, :only => [:create, :destroy]
  map.resources :messages, :only => [:index, :create]
end
