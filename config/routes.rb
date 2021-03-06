Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  root to: 'users#index' 
  resources :users, only: [:index, :new, :show, :edit, :update]  
  resources :posts do
    resources :comments, only: [:create, :destroy]
    resources :likes, only: [:create, :destroy]
    resources :favorites, only: [:create, :destroy]
  end
end