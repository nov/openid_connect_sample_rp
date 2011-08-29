ConnectRp::Application.routes.draw do
  resource :open_id, only: [:show, :create]
  resource :account, only: [:show, :destroy]

  root to: 'top#index'
end
