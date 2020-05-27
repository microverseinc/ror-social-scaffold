require 'rails_helper'

# RSpec.describe 'Creating a new event', type: :feature do
#   before :each do
#     create(:user, name: 'Oscar')
#     visit sessions_new_path
#     fill_in 'Name', with: 'Oscar'
#     click_on 'Submit'
#     visit new_event_path
#   end
#   scenario 'Fail to create a new event' do
#     click_on 'Submit'
#     expect(page).to have_content('Could not create event.')
#   end
#   scenario 'Create new event successfully' do
#     fill_in 'Location', with: 'Somewhere'
#     fill_in 'Time', with: DateTime.now + 1.day
#     click_on 'Submit'
#   end
# end
