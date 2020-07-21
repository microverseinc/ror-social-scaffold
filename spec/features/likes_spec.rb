require 'rails_helper'

RSpec.feature 'Likes', type: :feature do
  context 'In Main Page' do
    let!(:user) { create(:random_user) }
    let(:friend) { create(:random_friend) }
    let(:frienship_not_accepted) { create(:unconfirmed_friendship) }

    it 'user should successfully like a post' do
      create(:random_post)
      login_user(user)
      click_link('Like!')
      expect(page).to have_content('You liked a post.')
    end

    it 'user should be able to dislike a post' do
      create(:random_post)
      login_user(user)
      click_link('Like!')
      click_link('Dislike!')
      expect(page).to have_content('You disliked a post.')
    end
  end
end
