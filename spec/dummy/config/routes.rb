# frozen_string_literal: true

Rails.application.routes.draw do
  mount Mailpeek::Engine => '/mailpeek'
end
