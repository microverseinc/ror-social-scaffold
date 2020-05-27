require 'rails_helper'

# RSpec.describe EventAttendance, type: :model do
#   let(:event) { Event.create(location: 'Home', time: '2020-05-18 19:46:03') }
#   let(:user) { User.create(name: 'Oscar') }
#   let(:user2) { User.create(name: 'Alexis') }
#   subject { EventAttendance.new(attended_event: event, guest: user, accepted: nil) }
#   it 'is valid with valid attributes' do
#     expect(subject).to be_valid
#   end
#   it 'is not valid without valid attributes' do
#     subject.attended_event = nil
#     expect(subject).to_not be_valid
#   end
#   it 'is valid if the foreign key pair is unique' do
#     EventAttendance.create(attended_event: event, guest: user2, accepted: nil)
#     expect(subject).to be_valid
#   end
#   it 'is not valid if the foreign key pair is not unique' do
#     EventAttendance.create(attended_event: event, guest: user, accepted: nil)
#     expect(subject).to_not be_valid
#   end
#   it 'should belong to guest' do
#     t = EventAttendance.reflect_on_association(:guest)
#     expect(t.macro).to eq(:belongs_to)
#   end
#   it 'should belong to attended_event' do
#     t = EventAttendance.reflect_on_association(:attended_event)
#     expect(t.macro).to eq(:belongs_to)
#   end
# end
