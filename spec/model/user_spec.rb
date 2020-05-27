require 'rails_helper'

# RSpec.describe User, type: :model do
#   subject { User.new(name: 'Oscar') }
#   it 'is valid with valid attributes' do
#     expect(subject).to be_valid
#   end
#   it 'is not valid without a name' do
#     subject.name = nil
#     expect(subject).to_not be_valid
#   end
#   it 'is not valid if the name is not unique' do
#     User.create(name: 'Oscar')
#     expect(subject).to_not be_valid
#   end
#   it 'is valid if the name is unique' do
#     User.create(name: 'Oscar')
#     subject.name = 'Alexis'
#     expect(subject).to be_valid
#   end
#   it 'should have many hosted_events' do
#     t = User.reflect_on_association(:hosted_events)
#     expect(t.macro).to eq(:has_many)
#   end
#   it 'should have many attended_events' do
#     t = User.reflect_on_association(:attended_events)
#     expect(t.macro).to eq(:has_many)
#   end
#   it 'should have many event_attendances' do
#     t = User.reflect_on_association(:event_attendances)
#     expect(t.macro).to eq(:has_many)
#   end
# end
