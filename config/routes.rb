Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  root 'users#index' 
  resources :users, only: [:index, :new, :show, :edit, :update]  
  resources :posts, only: [:index, :new, :create, :show, :edit, :update]
end