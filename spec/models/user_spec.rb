require 'rails_helper'

RSpec.describe User, type: :model do

  # context 'Creating an Event' do
  #   it 'creates an event' do
  #     expect(event).to be_an Event
  #   end
  # end

  context 'Association test for event models' do
    it 'should have many attendeees' do
      t = User.reflect_on_association(:friendships)
      expect(t.macro).to eq(:has_many)
    end
    it 'should have many invitations' do
      t = User.reflect_on_association(:inverse_friendships)
      expect(t.macro).to eq(:has_many)
    end
  end
end
