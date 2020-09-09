require 'rails_helper'

RSpec.describe 'Friendship Requests', type: :request do
  let(:mary) do
    {
      name: 'mary', email: 'mary@web.com', password: 'password', password_confirmation: 'password'
    }
  end
  let(:jane) do
    {
      name: 'jane', email: 'jane@web.com', password: 'password', password_confirmation: 'password'
    }
  end

  describe 'a user should be able to access friendship routes' do
    before :each do
      post '/users', params: { user: mary }
    end

    it 'should be able to send a friend request to another user' do
      receiver = User.create(jane)
      post "/users/#{receiver.id}/friendship_requests"

      expect(response).to redirect_to user_path(receiver.id)
      expect(response).to have_http_status(:found)
      expect(response).to have_http_status(302)
      flash[:notice] = "A friendship request was successfully sent to #{receiver.name}"
    end

    it 'should be able to accept a friend request from another user' do
      receiver = User.find_by(email: mary[:email])
      sender = User.create(jane)

      sent_request = Friendship.create(friend: sender, inverse_friend: receiver)
      patch "/users/#{sender.id}/friendship_requests/#{sent_request.id}"

      expect(response).to redirect_to user_path(sender.id)
      expect(response).to have_http_status(:found)
      expect(response).to have_http_status(302)
      expect(flash[:notice]).to eq "You are now friends with #{sender.name}"
      expect(Friendship.find_by(friend: sender, inverse_friend: receiver, status: 'confirmed')).not_to eq nil
      expect(Friendship.find_by(friend: receiver, inverse_friend: sender, status: 'confirmed')).not_to eq nil
    end

    it 'should be able to reject a friend request from another user' do
      receiver = User.find_by(email: mary[:email])
      sender = User.create(jane)

      sent_request = Friendship.create(friend: sender, inverse_friend: receiver)
      delete "/users/#{sender.id}/friendship_requests/#{sent_request.id}"

      expect(response).to redirect_to user_path(sender.id)
      expect(response).to have_http_status(:found)
      expect(response).to have_http_status(302)
      expect(Friendship.find_by(friend: sender, inverse_friend: receiver)).to eq nil
      expect(Friendship.find_by(friend: receiver, inverse_friend: sender)).to eq nil
      flash_messge = "The friendship request from #{sender.name} was successfully rejected"
      expect(flash[:notice]).to eq flash_messge
    end
  end

  describe 'failure scenarios on the friendship routes' do
    before :each do
      post '/users', params: { user: jane }
    end

    it 'should not be able to send multiple friend requests to another user' do
      sender = User.find_by(email: jane[:email])
      receiver = User.create(mary)

      Friendship.create(friend: sender, inverse_friend: receiver)

      post "/users/#{receiver.id}/friendship_requests"

      expect(response).to redirect_to user_path(receiver.id)
      expect(response).to have_http_status(:found)
      expect(response).to have_http_status(302)
      flash_messge = 'An error occurred while trying to request the friendship ["Friend has already been taken"]'
      expect(flash[:alert]).to eq flash_messge
    end
  end
end
