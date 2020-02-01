# frozen_string_literal: true

describe Mailpeek::Delivery do
  subject(:delivery) { described_class.new(options) }

  let(:options) { {} }

  describe '#new' do
    let(:configuration) { Mailpeek::Configuration.new }

    it 'sets settings to default configuration' do
      settings = {
        limit: Mailpeek.configuration.limit,
        location: Mailpeek.configuration.location
      }

      expect(delivery.settings).to eq settings
    end

    context 'without location option' do
      before do
        configuration.location = nil

        allow(Mailpeek).to receive(:configuration).and_return(configuration)
      end

      it 'raises InvalidOption' do
        expect { delivery }.to raise_error(Mailpeek::Delivery::InvalidOption)
      end
    end

    context 'without limit option' do
      before do
        configuration.limit = nil

        allow(Mailpeek).to receive(:configuration).and_return(configuration)
      end

      it 'raises InvalidOption' do
        expect { delivery }.to raise_error(Mailpeek::Delivery::InvalidOption)
      end
    end

    context 'with limit set to non-number' do
      before do
        configuration.limit = 'invalid'

        allow(Mailpeek).to receive(:configuration).and_return(configuration)
      end

      it 'raises InvalidOption' do
        expect { delivery }.to raise_error(Mailpeek::Delivery::InvalidOption)
      end
    end
  end

  describe '#deliver!' do
    let(:path) { "./spec/support/emails/#{id}/mail" }
    let(:mail) { ::Mail.read(path) }
    let(:timestamp) { delivery.deliver!(mail) }
    let(:basepath) { File.join(Mailpeek.configuration.location, timestamp) }
    let(:file) { instance_double('File') }

    before do
      mail # declare first so our File stubs don't get in the way

      allow(FileUtils).to receive(:mkdir_p).and_return(true)

      allow(file).to receive(:write).and_return(file)
      allow(File).to receive(:open).and_yield(file)
    end

    context 'with email without attachments' do
      let(:id) { 'html_and_text' }

      it 'returns a timestamp' do
        expect(timestamp).to be_truthy
      end

      it 'creates a directory' do
        timestamp

        expect(FileUtils).to have_received(:mkdir_p).with(basepath).once
      end

      it 'opens a file' do
        timestamp

        expect(File).to(
          have_received(:open).with(File.join(basepath, 'mail'), 'w').once
        )
      end

      it 'saves a file' do
        timestamp

        expect(file).to have_received(:write).once
      end
    end

    context 'with attachment email' do
      let(:id) { 'html_text_and_attachment' }

      it 'returns a timestamp' do
        expect(timestamp).to be_truthy
      end

      it 'creates 2 directories' do
        timestamp

        expect(FileUtils).to have_received(:mkdir_p).twice
      end

      it 'opens 2 files' do
        timestamp

        expect(File).to have_received(:open).twice
      end

      it 'saves 2 files' do
        timestamp

        expect(file).to have_received(:write).twice
      end
    end
  end
end
