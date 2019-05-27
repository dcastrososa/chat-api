Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  resources :conversations, only: [:index, :create]
  resources :messages, only: [:create]
  resources :users, only: [:index]
  mount ActionCable.server => '/cable'
end
