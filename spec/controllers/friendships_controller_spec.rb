require 'rails_helper'
require './spec/support/request_spec_helper.rb'
include Warden::Test::Helpers
#include RequestSpecHelper
#include Devise::Test::ControllerHelpers

RSpec.describe FriendshipsController, type: :controller do
  it 'should create a new friendship request' do
    @requestor = User.create(name: "requestor", email: "requestor@gmail.com", password: "1234567", password_confirmation: "1234567")
    sign_in(@requestor)
    friend = User.create(name: "friend", email: "friend@gmail.com", password: "1234567", password_confirmation: "1234567")
    post :create, :params => { :id => friend.id }
    expect(response).to redirect_to user_path(friend.id)
  end

  it 'should confirm a requested friendship' do
    # @requestor = User.create(name: "requestor", email: "requestor@gmail.com", password: "1234567", password_confirmation: "1234567")
    # sign_in(@requestor)
    # receiver = User.create(name: "receiver", email: "receiver@gmail.com", password: "1234567", password_confirmation: "1234567")
    # post :create, :params => { :id => receiver.id }
    # expect(response).to redirect_to user_path(receiver.id)
  end
end
