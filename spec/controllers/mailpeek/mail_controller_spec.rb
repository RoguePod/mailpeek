require 'rails_helper'

module Mailpeek
  RSpec.describe MailController, type: :controller do
    routes { Mailpeek::Engine.routes }

    describe 'GET index' do
      context 'html' do
        it 'works' do
          get :index

          expect(response).to be_success
        end

        it 'sets @emails' do
          get :index

          expect(assigns(:emails)).to_not be_nil
          expect(assigns(:emails).size).to be > 0
        end
      end

      context 'json' do
        it 'works' do
          get :index, format: :json

          expect(response).to be_success
        end

        it 'sets @emails' do
          get :index, format: :json

          expect(assigns(:emails)).to_not be_nil
          expect(assigns(:emails).size).to be > 0
        end
      end
    end

    describe 'DELETE all' do
      before(:each) do
        expect(File).to receive(:delete).at_least(:once).and_return(true)
      end

      it 'works' do
        delete :destroy_all, format: :json

        expect(response).to be_success
      end
    end

    describe 'DELETE destroy' do
      let(:filename) do
        Dir.foreach(Rails.root.join('tmp', 'mailpeek')) do |filename|
          next if filename == '.' || filename == '..'
          return filename
        end
        nil
      end

      before(:each) do
        allow(File).to receive(:delete).and_return(true)
      end

      it 'works with invalid id' do
        expect(File).to receive(:delete).exactly(0).times
        delete :destroy, id: 'invalid', format: :json

        expect(response).to be_success
      end

      it 'works with valid id' do
        expect(File).to receive(:delete).exactly(1).times
        delete :destroy, id: filename, format: :json

        expect(response).to be_success
      end
    end
  end
end
