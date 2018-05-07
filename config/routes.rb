Rails.application.routes.draw do
  root "welcome#index"

  get '/login' => "sessions#login", as: "login"
  get '/logout' => "sessions#logout", as: "logout"
  get 'sessions/home'
  get 'sessions/profile'
  get 'sessions/setting'
  post '/login' => "sessions#login_attempt"

  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
