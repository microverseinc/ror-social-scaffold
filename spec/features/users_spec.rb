require 'rails_helper'

RSpec.feature 'Users', type: :feature do
  context 'Users exist' do
    let!(:user) { create(:random_user) }
    let(:friend) { create(:random_friend) }
    let(:frienship_not_accepted) { create(:unconfirmed_friendship) }

    it 'successfully login the user' do
      login_user(user)
    end

    it 'can\'t login with a blank password' do
    end
  end
end
