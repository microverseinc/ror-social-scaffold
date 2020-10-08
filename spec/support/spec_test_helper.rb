RSpec.configure do |config|
  config.before(type: :feature) do
    @user = User.create(name: 'Alexoid Z', email: 'amerox@opal.com', password: 'itsG00d2Have$')
    @user2 = User.create(name: 'Lencha B', email: 'lenchax@opal.com', password: 'itsG00d2Have$')
    @user3 = User.create(name: 'Lily Y', email: 'selamx@opal.com', password: 'itsG00d2Have$')
    @user4 = User.create(name: 'Jilly M', email: 'ahmedx@opal.com', password: 'itsG00d2Have$')

    @user.friendships.build(friend_id: @user2.id).save
    @user3.friendships.build(friend_id: @user.id).save

    Post.create(user_id: @user.id, content: 'I am the world!')
  end

  def login()
    before do
      visit new_user_session_path
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: @user.password
      click_on 'Log in'
    end
  end
end
