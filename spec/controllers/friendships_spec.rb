require 'rails_helper'

RSpec.describe FriendshipsController do
  context 'Actions' do
    it 'creates @comment' do
      friendship = Friendship.create
      get :create
      expect(assigns(:friendship)).to eq([friendship])
    end
  end
end
