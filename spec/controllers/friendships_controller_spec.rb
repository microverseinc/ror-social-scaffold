require 'rails_helper'
require './spec/support/request_spec_helper.rb'

RSpec.describe FriendshipsController, type: :controller do
  include Warden::Test::Helpers
  # rubocop:disable Style/HashSyntax
  # rubocop:disable Layout/LineLength:

  let(:requestor) { User.create(name: 'requestor', email: 'requestor@gmail.com', password: '1234567', password_confirmation: '1234567') }

  it 'should create a new friendship request' do
    sign_in(requestor)
    friend = User.create(name: 'friend', email: 'friend@gmail.com', password: '1234567', password_confirmation: '1234567')
    post :create, :params => { :id => friend.id }
    expect(response).to redirect_to user_path(friend.id)
  end

  it 'should confirm a requested friendship' do
    sign_in(requestor)
    receiver = User.create(name: 'receiver', email: 'receiver@gmail.com', password: '1234567', password_confirmation: '1234567')
    post :create, :params => { :id => receiver.id }
    sign_out(requestor)
    sign_in(receiver)
    post :update, :params => { :id => requestor.id }
    expect(response).to redirect_to user_path(requestor.id)
  end
  # rubocop:enable Layout/LineLength:
  # rubocop:enable Style/HashSyntax
end
