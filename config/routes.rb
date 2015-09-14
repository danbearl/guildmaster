Rails.application.routes.draw do

  get 'profiles/show'

  get 'users/new'

  root 'welcome#index'

  get 'log_in' => 'sessions#new', as: 'log_in'
  get 'log_out' => 'sessions#destroy', as: 'log_out'

  resources :sessions
  resources :users, only: [:new, :delete] do
    resources :profiles, only: [:show, :edit]
  end
end
