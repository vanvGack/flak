ActionController::Routing::Routes.draw do |map|
  map.resources :users, :only => :create
  map.resource  :session, :only => [:create, :destroy]
  map.resources :messages, :only => [:index, :create]
end
