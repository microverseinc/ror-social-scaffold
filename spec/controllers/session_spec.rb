require './rails_helper'

describe Session, type: :controller do
  context 'validates required fields' do
    it 'returns false when name is not present' do
      Session.new expect(session.valid?).to eq(false)
    end
    it 'returns true when username is present' do
      session = Session.new session.name = 'valid'
      expect(session.valid?).to eq(true)
    end
  end
end
