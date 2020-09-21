require "rails_helper"

RSpec.describe Friendship, :type => :model do
    describe 'Association test' do
        it 'has friendships' do
            user = User.reflect_on_association(:friendships)
            expect(user.macro).to eq(:has_many)
        end
    end
end