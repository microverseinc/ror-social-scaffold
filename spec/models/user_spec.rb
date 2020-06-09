require 'rails_helper.rb'

describe User, type: :model do

  context "creates new user" do

    it "Creates a new valid user" do
      u = User.new(name: 'user1', email: 'user1@mail.com', \
        password: '123456', password_confirmation: '123456')
      u.save
      expect(u.persisted?).to eql(true)
    end

    it "fails if name not present" do
      u = User.new( email: 'user1@mail.com' )
      u.save
      expect(u.persisted?).to eql(false)
    end
    
    it "fails if name length > 20" do
      u = User.new( name: '123456789012345678901', email: 'user1@mail.com' )
      u.save
      expect(u.persisted?).to eql(false)
    end
  end
  
  context "User log in Log out" do

    it "User should be able to login the app" do
      user1 = User.new(name: 'user1', email: 'user1@mail.com', \
        password: '123456', password_confirmation: '123456')
      user1.save
      visit("/users/sign_in")
      fill_in "user_email", with: "user1@mail.com"
      fill_in "user_password", with: "123456"
      click_button 'Log in'
      expect(page).to have_content 'Signed in successfully'
    end
  end

  #describe "User relationships" do

  #   it "has many friendships" do
  #     t.User.reflect_on_association(:friendship)
  #     expect(t.macro).to eql(:has_many)
  #   end

  #   it "has many inverse friendships" do
  #     t.User.reflect_on_association(:inverse_friendships)
  #     expect(t.macro).to eql(:has_many)
  #   end

  #   it "has many pending friends" do
  
  
  #log in with user
  
  #     #create a user friend-to-be
  #     #friend1 = User.create(email: "friend1@mail.com", name: "friend1", password: "password")
  #     #create a friendship request
  #     #expect(user.pending_friends).to include(friend1)
  #   end

  #   it "has many posts" do
  #   end

  #   it "has many comments" do
  #   end

  #   it "has many inverse friendships" do
  #   end

  #   it "Confirms a friendship request" do
  #   end
  #end
end