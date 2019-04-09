Rails.application.routes.draw do
  resources :users, only: [:show]
  resources :recipes, only: [:index]
  resources :foods, only: [:index]
  resources :user_foods, only: [:create]
  resources :user_recipes, only: [:create]
  delete '/user_recipes', to: 'user_recipes#destroy'

  patch '/user_foods/eat', to: 'user_foods#eat'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
