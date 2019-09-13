Rails.application.routes.draw do
  devise_for :users
  root 'blogs#index'
  resources :blogs do
    resources :comments, only: [:create]
  end
  resources :users, only: [:show]
end
