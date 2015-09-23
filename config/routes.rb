Rails.application.routes.draw do

  get 'tasks/new'

  root 'welcome#index'

  get 'log_in' => 'sessions#new', as: 'log_in'
  get 'log_out' => 'sessions#destroy', as: 'log_out'
  get 'adventurer/:id/fire' => 'adventurers#fire', as: 'fire_adventurer'
  get 'adventurer/:id/hire' => 'adventurers#hire', as: 'hire_adventurer'
  get 'adventurers/market' => 'adventurers#market', as: 'adventurer_market'
  get 'contract/:id/tasks/new' => 'tasks#new', as: 'new_contract_task'
  post 'adventurers/:id/contract/:id/tasks/create' => 'tasks#create', as: 'new_adventurer_contract_task'

  resources :sessions
  resources :profiles
  resources :guildhalls
  resources :bids, only: [:new, :create]
  resources :quests, only: [:index, :show] do
    resources :bids, only: [:new, :create]
  end
  resources :adventurers, only: [:new, :create, :show, :index]
  resources :users, only: [:new, :create, :destroy] do
    resource :profile, only: [:show, :edit]
    resource :guildhall, only: [:show, :edit]
  end
end
