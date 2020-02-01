# frozen_string_literal: true

describe Mailpeek::Delivery do
  subject(:delivery) { described_class.new(options) }

  let(:options) { {} }
  let(:id) { 'html_and_text' }
  let(:path) { "./spec/support/emails/#{id}/mail" }
  let(:mail) { ::Mail.read(path) }

  describe '#new' do
    it 'sets settings to default configuration' do
      settings = {
        limit: Mailpeek.configuration.limit,
        location: Mailpeek.configuration.location
      }

      expect(delivery.settings).to eq settings
    end

    context 'without location option' do
      before do
        Mailpeek.configure do |c|
          c.location = nil
        end
      end

      it 'raises InvalidOption' do
        expect { delivery }.to raise_error(Mailpeek::Delivery::InvalidOption)
      end
    end

    context 'without limit option' do
      before do
        Mailpeek.configure do |c|
          c.limit = nil
        end
      end

      it 'raises InvalidOption' do
        expect { delivery }.to raise_error(Mailpeek::Delivery::InvalidOption)
      end
    end

    context 'with limit set to non-number' do
      before do
        Mailpeek.configure do |c|
          c.limit = 'invalid'
        end
      end

      it 'raises InvalidOption' do
        expect { delivery }.to raise_error(Mailpeek::Delivery::InvalidOption)
      end
    end
  end
end
