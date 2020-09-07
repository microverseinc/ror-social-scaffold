require 'rails_helper'

require 'support/devise_config'

RSpec.describe FriendshipRequestsController, type: :controller do
  describe 'post friend request' do
    log_in_usr :sender, 'jane', 'jane@gmail.com'

    it 'successfully sends a friend request and sets the correct flash notice' do
      receiver = create(:receiver, name: 'marylene', email: 'marylene@gmail.com')
      sender = User.find_by(name: 'jane', email: 'jane@gmail.com')
      post :create, params: { user_id: receiver.id }
      expect(response.code).to eq '302'
      expect(response).to have_http_status(:found)
      expect(flash[:notice]).to eq "A friendship request was successfully sent to #{receiver.name}"
      expect(Friendship.find_by(friend: sender, inverse_friend: receiver, status: 'pending')).not_to eq nil
    end

    it 'fails to post a friend request and sets the correct flash notice' do
      receiver = create(:receiver, name: 'marylene', email: 'marylene@gmail.com')
      sender = User.find_by(name: 'jane', email: 'jane@gmail.com')
      Friendship.create(friend: sender, inverse_friend: receiver)
      post :create, params: { user_id: receiver.id }
      expect(response.code).to eq '302'
      expect(response).to have_http_status(:found)
      expect(flash[:notice]).to eq nil
      expect(flash[:alert])
        .to eq 'An error occurred while trying to request the friendship ["Friend has already been taken"]'
    end
  end

  describe 'update friend request' do
    log_in_usr :receiver, 'marylene', 'marylene@gmail.com'

    it 'successfully accepts a friend request, creates a friendship and sets the correct flash notice' do
      sender = create(:sender, name: 'jane', email: 'jane@gmail.com')
      receiver = User.find_by(name: 'marylene', email: 'marylene@gmail.com')

      sent_request = Friendship.create(friend: sender, inverse_friend: receiver)

      patch :update, params: { user_id: sender.id, id: sent_request.id }
      expect(response.code).to eq '302'
      expect(response).to have_http_status(:found)
      expect(flash[:notice]).to eq "You are now friends with #{sender.name}"
      expect(Friendship.find_by(friend: sender, inverse_friend: receiver)).not_to eq nil
      expect(Friendship.find_by(friend: receiver, inverse_friend: sender)).not_to eq nil
    end
  end

  describe 'destroy friend request' do
    log_in_usr :receiver, 'marylene', 'marylene@gmail.com'

    it 'rejects a friend request, creates a friendship and sets the correct flash notice' do
      sender = create(:sender, name: 'jane', email: 'jane@gmail.com')
      receiver = User.find_by(name: 'marylene', email: 'marylene@gmail.com')

      sent_request = Friendship.create(friend: sender, inverse_friend: receiver)

      delete :destroy, params: { user_id: sender.id, id: sent_request.id }
      expect(response.code).to eq '302'
      expect(response).to have_http_status(:found)
      expect(flash[:notice]).to eq "The friendship request from #{sender.name} was successfully rejected"
      expect(Friendship.find_by(friend: sender, inverse_friend: receiver, status: 'pending')).to eq nil
    end
  end
end
