Rails.application.routes.draw do
  get 'sessions/login'

  get 'sessions/home'

  get 'sessions/profile'

  get 'sessions/setting'

  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
