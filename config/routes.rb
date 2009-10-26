ActionController::Routing::Routes.draw do |map|
  map.resources :users
  map.resource  :session
  map.resources :messages
end
