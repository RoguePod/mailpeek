# frozen_string_literal: true

describe Mailpeek::Email do
  subject(:email) { described_class.new(id, ::Mail.read(path)) }

  let(:path) { "./spec/support/emails/#{id}/mail" }
  let(:id) { 'html_and_text' }

  describe '#new' do
    context 'with html and text email' do
      it 'sets html' do
        expect(email.html.nil?).to eq false
      end

      it 'sets text' do
        expect(email.text.nil?).to eq false
      end

      it 'has 0 attachments' do
        expect(email.attachments.empty?).to eq true
      end
    end

    context 'with text email' do
      let(:id) { 'text' }

      it 'does not set html' do
        expect(email.html.nil?).to eq true
      end

      it 'sets text' do
        expect(email.text.nil?).to eq false
      end

      it 'has 0 attachments' do
        expect(email.attachments.empty?).to eq true
      end
    end

    context 'with html email' do
      let(:id) { 'html' }

      it 'sets html' do
        expect(email.html.nil?).to eq false
      end

      it 'does not set text' do
        expect(email.text.nil?).to eq true
      end

      it 'has 0 attachments' do
        expect(email.attachments.empty?).to eq true
      end
    end

    context 'with html, text and attachment email' do
      let(:id) { 'html_text_and_attachment' }

      it 'sets html' do
        expect(email.html.nil?).to eq false
      end

      it 'sets text' do
        expect(email.text.nil?).to eq false
      end

      it 'has attachments' do
        expect(email.attachments.empty?).to eq false
      end
    end
  end

  describe '#match?' do
    let(:results) { email.match?(query) }

    context 'with valid query' do
      let(:query) { 'Itaque' }

      it 'returns true' do
        expect(results).to be_truthy
      end
    end

    context 'with invalid query' do
      let(:query) { 'Invalid' }

      it 'returns true' do
        expect(results).to be_falsey
      end
    end
  end

  describe '#destroy' do
    before do
      allow(FileUtils).to receive(:rm_rf).and_return(true)
    end

    it 'returns true' do
      expect(email.destroy).to eq true
    end

    it 'removes directory' do
      email.destroy

      with = "#{Mailpeek.configuration.location}/#{id}"

      expect(FileUtils).to have_received(:rm_rf).with(with).once
    end
  end

  describe '#read' do
    context 'with read email' do
      it 'returns true' do
        expect(email.read).to eq true
      end
    end

    context 'with unread email' do
      let(:id) { 'text' }

      it 'returns false' do
        expect(email.read).to eq false
      end
    end
  end

  describe '#read=' do
    context 'with read email' do
      after do
        email.read = true
      end

      it 'unreads file' do
        email.read = false
        expect(email.read).to eq false
      end
    end

    context 'with unread email' do
      let(:id) { 'html' }

      after do
        email.read = false
      end

      it 'unreads file' do
        email.read = true
        expect(email.read).to eq true
      end
    end
  end
end
