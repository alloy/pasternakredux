ActionController::Routing::Routes.draw do |map|
  map.resources :pastes
  map.formatted_paste_url '/pastes/:id.:format', :controller => 'pastes', :action => 'show'
end
