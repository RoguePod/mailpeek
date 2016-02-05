Mailpeek::Engine.routes.draw do
  resources :mail, only: [:index, :destroy]

  root to: 'mail#index'
end
