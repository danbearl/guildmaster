Rails.application.routes.draw do

  root 'welcome#index'

  get 'log_in' => 'sessions#new', as: 'log_in'
  get 'log_out' => 'sessions#destroy', as: 'log_out'

  resources :sessions
  resources :profiles
  resources :guildhalls
  resources :adventurers, only: [:new, :create, :show, :index]
  resources :users, only: [:new, :create, :destroy] do
    resource :profile, only: [:show, :edit]
    resource :guildhall, only: [:show, :edit]
  end
end
