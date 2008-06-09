ActionController::Routing::Routes.draw do |map|
  map.resources :pastes, :sessions, :users
  map.formatted_paste_url '/pastes/:id.:format', :controller => 'pastes', :action => 'show'
end
