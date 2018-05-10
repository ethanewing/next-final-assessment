Rails.application.routes.draw do
  resources :relationships, only: [:create, :destroy]

  resources :pictures
  root "welcome#index"

  get '/login' => "sessions#login", as: "login"
  get '/logout' => "sessions#logout", as: "logout"
  post '/login' => "sessions#login_attempt"

  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
