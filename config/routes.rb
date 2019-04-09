Rails.application.routes.draw do
  resources :users, only: [:create]
  resources :recipes, only: [:index]
  resources :foods, only: [:index]
  resources :user_foods, only: [:create]
  resources :user_recipes, only: [:create]
  post '/login', to: 'auth#create'
  delete '/user_recipes', to: 'user_recipes#destroy'
  get '/users', to: 'users#show'
  patch '/user_foods/eat', to: 'user_foods#eat'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
