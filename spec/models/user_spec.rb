require 'rails_helper'

RSpec.describe User, type: :model do
  subject(:user) { User.new(name: 'Paul', email: 'paul@mail.com', password: '123456') }

  describe 'Validations' do
    # Name
    it { should validate_length_of(:name).is_at_most(20) }

    it { should_not allow_value('').for(:name) }

    long_name = (0..20).map { ('a'..'z').to_a[rand(26)] }.join
    it { should_not allow_value(long_name).for(:name) }

    it { should allow_value(user.name).for(:name) }

    # Email
    it { should validate_presence_of(:email) }

    email = (0...30).map { ('a'..'z').to_a[rand(26)] }.join
    it { should_not allow_value(email).for(:email) }

    it { should allow_value(user.email).for(:email) }

    it { should validate_uniqueness_of(:email).case_insensitive }

    # Password
    it { should validate_presence_of(:password) }

    password = (0...5).map { ('a'..'z').to_a[rand(26)] }.join
    it { should_not allow_value(password).for(:password) }

    it { should_not allow_value('').for(:password) }

    it { should allow_value(user.password).for(:password) }
  end

  describe 'User' do
    # Posts
    it { should have_many(:posts) }

    # Comments
    it { should have_many(:comments).dependent(:destroy) }

    # Likes
    it { should have_many(:likes).dependent(:destroy) }

    # Friendships
    it { should have_many(:friendships) }

    # Received Friendships
    it { should have_many(:received_friendships).with_foreign_key('friend_id').class_name('Friendship') }
  end
end
