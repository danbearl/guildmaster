Rails.application.routes.draw do

  get 'users/new'

  root 'welcome#index'

  get 'log_in' => 'sessions#new', as: 'log_in'
  get 'log_out' => 'sessions#destroy', as: 'log_out'

  resources :sessions
end
