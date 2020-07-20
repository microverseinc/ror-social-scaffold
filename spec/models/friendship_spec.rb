require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:user) { User.create(name: 'Temmarie', email: 'Tam@email.com', password: 'tamara') }
  let(:friend) { User.create(name: 'Becca', email: 'Becca@email.com', password: 'rebecca') }
  let(:friendship) { Friendship.create(user_id: user.id, friend_id: friend.id) }

end