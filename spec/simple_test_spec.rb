require 'rails_helper'

RSpec.describe 'Simple Test', type: :system do
  describe 'root page' do
    it 'shows the right content' do
      visit root_path
      sleep(5)
      expect(page).to have_content('Signin')
    end
  end
end
