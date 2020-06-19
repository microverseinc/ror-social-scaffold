require 'rails_helper'

RSpec.describe FriendshipsController, type: :controller do
  context 'friendship controller ' do
    let(:sam) { User.create(email: 'sbham@gmail.com', name: 'Shubham Singh', password: 'minglecuppika') }
    let(:ryan) { User.create(email: 'rya\nlin@gmail.com', name: 'Ryan Dmhl', password: 'lodasespika') }

    it 'creates the friendship' do
      expect { Friendship.create(user_id: sam.id, friend_id: ryan.id) }.to change { Friendship.count }.by(1)
    end
  end
end
