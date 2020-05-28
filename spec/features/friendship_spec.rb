require 'rails_helper'

RSpec.describe 'Creating a new invitation', type: :feature do
    before :each do
        user1 = User.create(name: 'Oscar', email: "o@mail.com",  password: '123456')
        user2 = User.create(name: 'Alexis', email: "a@mail.com",  password: '123456')
        user1.posts.create(content: 'A new post by Oscar.')
        
    
        visit user_session_path
        fill_in 'Email', with: 'a@mail.com'
        fill_in 'Password', with: '123456'
        click_on 'Log in'
      end
    
      scenario 'Send a friendship invitation ' do
        click_on 'All users'
        click_on 'Invite'
        expect(page).to have_content("Friendship was successfully created.")
      end

      scenario 'Decline a friendship invitation ' do
        click_on 'All users'
        click_on 'Invite'
        click_on 'Sign out'
        fill_in 'Email', with: 'o@mail.com'
        fill_in 'Password', with: '123456'
        click_on 'Log in'
        click_on 'All users'
        click_on 'Decline'
        expect(page).to have_content("Friendship was successfully destroyed.")
      end

      scenario 'Accept a friendship invitation ' do
        click_on 'All users'
        click_on 'Invite'
        click_on 'Sign out'
        fill_in 'Email', with: 'o@mail.com'
        fill_in 'Password', with: '123456'
        click_on 'Log in'
        click_on 'All users'
        click_on 'Accept'
        expect(page).to have_content("Friendship was successfully updated.")
      end
end
