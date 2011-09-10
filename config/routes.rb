ConnectRp::Application.routes.draw do
  resources :providers do
    resource :open_id, only: [:show, :create]
  end
  resource :account, only: [:show, :destroy]

  root to: 'top#index'
end
