ConnectRp::Application.routes.draw do
  resources :providers, except: :show do
    resource :open_id, only: [:show, :create]
  end
  resource :account, only: :show
  resource :session, only: :destroy

  root to: 'top#index'
end
