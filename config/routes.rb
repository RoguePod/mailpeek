# frozen_string_literal: true

Mailpeek::Engine.routes.draw do
  resources :emails, only: %i[index destroy show] do
    collection do
      delete :index, action: :destroy_all
      get :read
    end

    resources :attachments, only: %i[show]
  end

  root to: 'emails#index'
end
