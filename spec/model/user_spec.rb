require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation' do
    subject do
      described_class.new(name: 'Foobar', email: 'foobar', password: 'foobar')
    end

    it 'is valid with valid name' do
      expect(subject).to be_valid
    end

    it 'is not valid without a name' do
      subject.name = nil
      expect(subject).to_not be_valid
    end
  end

#   context 'Association' do
#     it 'should have many created_events' do
#       t = User.reflect_on_association(:created_events)
#       expect(t.macro).to eq(:has_many)
#     end
#     it 'should have many event_attendees' do
#       t = User.reflect_on_association(:event_attendees)
#       expect(t.macro).to eq(:has_many)
#     end
#     it 'should have many attending_events' do
#       t = User.reflect_on_association(:attending_events)
#       expect(t.macro).to eq(:has_many)
#     end
#   end
end
