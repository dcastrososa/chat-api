Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  resources :conversations, only: [:index, :create]
    get "/conversations/users/new" => "conversations#users_for_new_conversations"
  resources :messages, only: [:create]
  resources :users, only: [:index, :show]
  mount ActionCable.server => '/cable'
end
