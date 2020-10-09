require 'rails_helper'
require 'capybara/rspec'

RSpec.describe FriendshipsController, type: :feature do
  context 'timeline displays friends posts' do
    let(:user1) { User.create(id: '2', name: 'Ramin', email: 'ramin@ramin.com', password: '123456') }
    let(:user2) { User.create(id: '3', name: 'Jurgen', email: 'jurgen@jurgen.com', password: '654321') }

    before :each do
      visit new_user_session_path
      fill_in 'user_email', with: user1.email
      fill_in 'user_password', with: user1.password
      click_button 'Log in'
    end

    scenario 'send friend request (add friend)' do
      visit users_path
      find(:css, '#add_friend_class').click
      # visit addfriend_path(user_id: user1.id, friend_id: user2.id)
      p user2.friendships
      expect(page).to have_content('Name: Ramin See Profile')
    end

    scenario 'approve the friendship request sent' do
      # visit user_path(user2.id)
      # visit approve_friendship_path(user_id: user1.id, friend_id: user2.id)
      # expect(user1.friendships.find_by(user_id: user1.id, friend_id: user2.id).confirmed).to eql?(true)
    end

    scenario 'remove friend (unfriend)' do

    end



    scenario 'decline the friend request sent' do

    end
  end



  # context 'Actions' do
  #   it 'creates @friendship ' do
  #     friendship = Friendship.new(user_id: user1.id, friend_id: user2.id)
  #     friendship.save
  #     expect(user1.friendships.where(user_id: user1.id, friend_id: user2.id)).to eq([friendship])
  #   end
  # end
  #
  # context 'Actions' do
  #   it 'destroys @friendship' do
  #
  #   end
  # end
  #
  # context 'Actions' do
  #   it 'approves @friendship' do
  #
  #   end
  # end
end
