ActionController::Routing::Routes.draw do |map|
  map.resources :pastes
  map.formatted_paste_url '/pastes/:id.:format', :controller => 'pastes', :action => 'show'
  map.themed_paste_url '/pastes/:id/theme/:theme', :controller => 'pastes', :action => 'show'
end
