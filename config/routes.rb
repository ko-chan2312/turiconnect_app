Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root 'homes#top'
  resources :posts,  only: [:index, :show, :create, :destroy] do
    resources :comments, only: [:create]
  end
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :relationships,  only: [:create, :destroy]
  resources :messages, only:  [:create]
  resources :rooms, only: [:create, :show, :index]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
