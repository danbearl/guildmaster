Rails.application.routes.draw do
  root 'welcome#index'

  get 'log_in' => 'sessions#new', as: 'log_in'
  get 'log_out' => 'sessions#destroy', as: 'log_out'

  resources :sessions
  resources :profiles
  resources :users, only: [:new, :create, :delete] do
    resource :profile, only: [:show, :edit]
  end
end
