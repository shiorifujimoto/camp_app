Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations'
  }
  root to: 'users#index' 
  resources :users, only: [:index, :new, :show, :edit, :update]  
  resources :posts do
    collection do
      get 'tag_search'
    end
    get 'tag_search', on: :member
  end
end