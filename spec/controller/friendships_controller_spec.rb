require 'rails_helper'

# rspec spec\controller\friendships_controller_spec.rb
RSpec.describe FriendshipsController, type: :controller do
  let(:user1) { User.create(name: 'test', email: 'email@email.com', password: 'abc123') }
  let(:user2) { User.create(name: 'test2', email: 'email2@email.com', password: 'abc123') }
  let(:friendship1) { user1.friendships.create(friend_id: 2) }

  describe '#update' do
    setup do
      get '/users/sign_in' //getting url for sign in
      sign_in users(:u_1) //signing an user difned in my yml that is valid and therefore in the 'database'
      post user_session_url // posting to the url that will indeed get u_1 logged
    end

    it 'acceptance should become true' do
      user1
      user2
      friendship1

      expect { patch :update, params: { id: 1 } }
        .to change(friendship1, :acceptance).to eql(true)
    end
  end
end
