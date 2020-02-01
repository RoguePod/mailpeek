# frozen_string_literal: true

describe Mailpeek do
  describe '.emails' do
    it 'returns all emails' do
      expect(described_class.emails.size).to eq 4
    end
  end

  describe '.unread' do
    it 'returns count of unread emails' do
      expect(described_class.unread).to eq 3
    end
  end

  describe '.email' do
    let(:id) { 'html_and_text' }

    it 'returns email by id' do
      expect(described_class.email(id).id).to eq id
    end
  end

  describe '.prep_folder' do
    it 'creates folder to store emails, if does not exist' do
      allow(File).to receive(:directory?).and_return(false)
      allow(FileUtils).to receive(:mkdir_p).and_return(true)

      described_class.prep_folder

      location = described_class.configuration.location

      expect(FileUtils).to have_received(:mkdir_p).once.with(location)
    end
  end
end
