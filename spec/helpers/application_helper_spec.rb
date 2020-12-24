require 'rails_helper'

RSpec.describe 'Application Helper', type: :helper do
  let(:user) { User.create(id: '1', name: 'user1', email: 'user1@example.com', password: 'aaaaaa') }
  let(:user2) { User.create(id: '2', name: 'user2', email: 'user2@example.com', password: 'aaaaaa') }
  let(:friendship) { Friendship.create(user_id: user.id, friend_id: user2.id, confirmed: false) }

  context 'helper methods' do
  end
end
