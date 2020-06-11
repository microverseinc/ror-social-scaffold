require 'rails_helper'

RSpec.describe 'Main Flow', type: :system do
  describe 'First User of Platform' do
    it 'Creates Account and create a post' do
      visit('/')
      sleep 1

      # Register
      click_link find_by_id('sign_up-link')
      sleep 5


    end
  end
end