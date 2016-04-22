Rails.application.routes.draw do
  resources :submissions, only: [:show, :create]
  resources :claims, only: [:show, :update]
  post 'search' => 'search#search', as: :search
end
