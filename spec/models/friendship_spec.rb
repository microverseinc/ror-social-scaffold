require 'rails_helper'

RSpec.describe Friendship, type: :model do
  context 'Friendship Association' do
    let(:user1) { User.new(name: 'userfirst', email: 'firstuser@test.com', password: 'passdow321') }
    let(:user2) { User.new(name: 'seconduser', email: 'user2@test.com', password: 'password') }
    let(:friendship) { Friendship.new(confirmed: false) }

    it { should belong_to(:user) }
    it { should belong_to(:friend) }
  end
end
