Mailpeek::Engine.routes.draw do
  resources :mail, only: [:index, :destroy] do
    collection do
      delete :index, action: :destroy_all
    end
  end

  root to: 'mail#index'
end
