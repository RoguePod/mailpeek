# frozen_string_literal: true

require 'rails_helper'

# Public: Mailpeek
module Mailpeek
  RSpec.describe EmailsController, type: :controller do
    routes { Mailpeek::Engine.routes }

    describe 'GET #index' do
      context 'when html' do
        it 'works' do
          get :index

          expect(response).to have_http_status(:found)
        end

        it 'sets @emails' do
          get :index

          expect(assigns(:emails)).not_to be_nil
        end

        it 'sets @emails to multiple' do
          get :index

          expect(assigns(:emails).size).to eq 2
        end
      end

      context 'when json' do
        it 'works' do
          get :index, format: :json

          expect(response).to be_successful
        end

        it 'sets @emails' do
          get :index, format: :json

          expect(assigns(:emails)).not_to be_nil
        end

        it 'sets @emails to multiple' do
          get :index, format: :json

          expect(assigns(:emails).size).to eq 2
        end
      end
    end

    describe 'DELETE #destroy_all' do
      before do
        allow(FileUtils).to receive(:rm_rf).at_least(:once).and_return(true)
      end

      it 'works' do
        delete :destroy_all, format: :json

        expect(response).to have_http_status(:found)
      end
    end

    describe 'DELETE #destroy' do
      let(:filename) do
        Dir.foreach(Mailpeek.configuration.location) do |filename|
          next if ['.', '..'].include?(filename)

          return filename
        end

        nil
      end

      before do
        allow(FileUtils).to receive(:rm_rf).and_return(true)
      end

      context 'with invalid id' do
        it 'does not delete' do
          delete :destroy, params: { id: 'invalid' }, format: :json

          expect(response).to have_http_status(:found)
        end
      end

      context 'with valid id' do
        it 'does delete' do
          delete :destroy, params: { id: filename }, format: :html

          expect(response).to have_http_status(:found)
        end
      end
    end
  end
end
