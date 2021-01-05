require 'rails_helper.rb'

describe 'testing friendship features', type: :feature do
  before :each do
    @test_friend = User.create!({ name: 'Kelyn',
                                  email: 'kelyn@gmail.com',
                                  password: '111111',
                                  password_confirmation: '111111' })
    @test_user = User.create!({ name: 'Alex',
                                email: 'alex@gmail.com',
                                password: '111111',
                                password_confirmation: '111111' })
    @test_friend_request = User.create!({ name: 'Chuck',
                                          email: 'chuckster@gmail.com',
                                          password: '111111',
                                          password_confirmation: '111111' })
    @friendship = Friendship.create!({ user_id: @test_friend_request.id,
                                       friend_id: @test_friend.id,
                                       confirmed: nil })

    @post = Post.create!({ user_id: @test_friend_request.id,
                           content: 'Test post from Chuck' })
  end

  ## Creating
  describe 'Performing actions as Kelyn' do
    before :each do
      visit 'users/sign_in'
      fill_in 'Email', with: 'kelyn@gmail.com'
      fill_in 'Password', with: '111111'
      click_button 'Log in'
      visit 'users'
    end
    it 'login was made' do
      expect(page).to have_content 'Kelyn'
    end
    it 'users is listed in users index' do
      expect(page).to have_content 'Alex'
    end

    it 'friend Requests are rendered' do
      visit 'friendships'
      expect(page).to have_content 'Friend Requests'
    end

    it 'accept Friend Request' do
      visit 'friendships'
      sleep(2)
      click_link('Accept', match: :first)
      expect(page).to have_content 'Friend request was accepted.'
    end

    it 'display list of friends posts' do
      visit 'friendships'
      click_link 'Accept'
      sleep(2)
      visit 'posts'
      expect(page).to have_content 'Test post from Chuck'
    end

    it 'if friendship was accepted create a new row for inverse friendship' do
      visit 'friendships'
      expect { click_link 'Accept' }.to change(Friendship, :count).by(1)
    end
  end
end
