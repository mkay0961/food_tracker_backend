Rails.application.routes.draw do
  resources :users, only: [:show]
  resources :recipes, only: [:index]
  resources :foods, only: [:index]
  resources :user_foods, only: [:update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
