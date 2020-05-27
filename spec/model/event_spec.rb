require 'rails_helper'

# RSpec.describe Event, type: :model do
#   subject { Event.new(location: 'Home', time: '2020-05-18 19:46:03') }
#   it 'is valid with valid attributes' do
#     expect(subject).to be_valid
#   end
#   it 'is not valid without valid attributes' do
#     subject.location = nil
#     expect(subject).to_not be_valid
#   end
#   it 'should belong to host' do
#     t = Event.reflect_on_association(:host)
#     expect(t.macro).to eq(:belongs_to)
#   end
#   it 'should have many event_attendances' do
#     t = Event.reflect_on_association(:event_attendances)
#     expect(t.macro).to eq(:has_many)
#   end
#   it 'should have many guests' do
#     t = Event.reflect_on_association(:guests)
#     expect(t.macro).to eq(:has_many)
#   end
# end
