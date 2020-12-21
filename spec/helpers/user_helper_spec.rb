require 'rails_helper'

RSpec.describe UsersHelper, type: :helper do
  let(:user1) { User.create(name: 'Joha', email: 'joha@gmail.com.com', password: '123456') }
  let(:user2) { User.create(name: 'Alex', email: 'alex@yahoo.com', password: 'password') }
  let(:post1) { Post.create(content: 'New post for test', user_id: user1.id) }

  describe '#confirm_friendship_button' do
    it 'return the button with the status of the frienship request' do
      Friendship.create(user_id: user1.id, friend_id: user2.id, status: 'requested')
      allow(helper).to receive(:current_user).and_return(user2)
      expect(helper.friendship_interaction(user1)).not_to be_nil
    end
  end

  describe '#friendship_button_show' do
    it 'show the status of the friendship' do
      Friendship.create(user_id: user1.id, friend_id: user2.id, status: 'requested')
      allow(helper).to receive(:current_user).and_return(user2)
      expect(helper.friendship_interaction(user1)).not_to be_nil
    end
  end
end
