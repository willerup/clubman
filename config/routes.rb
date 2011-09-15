Clubmanager::Application.routes.draw do

  get "parent/index"

  get "home/index"
  get "rating/index"

  resources :games
  resources :groups
  resources :students
  resources :users
  resources :families
  resources :clubs
  resources :user_sessions
  resources :events
  resources :terms
  
  match 'login', :to => 'user_sessions#new'
  match 'logout', :to => 'user_sessions#destroy'

  match 'new_parent.:id', :to => 'families#new_parent', :as => :new_parent
#  match 'games/new_player', :to => 'games#new_player', :as => :new_player

  root :to => "home#index"

  match ':controller(/:action(/:id(.:format)))'
end