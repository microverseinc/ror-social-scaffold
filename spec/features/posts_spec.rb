require 'rails_helper'

RSpec.feature 'Posts', type: :feature do
  context 'Users exist' do
    let!(:user) { create(:random_user) }
    let(:quote) { Faker::Movies::StarWars.quote }

    it 'should be able to create a post' do
      login_user(user)
      visit 'posts'
      within('form') do
        fill_in 'Add New Post', with: quote
      end
      click_button 'Save'
      expect(page).to have_content('Post was successfully created.')
    end
  end
end
