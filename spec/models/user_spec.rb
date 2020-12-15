require 'rails_helper'
RSpec.describe User, type: :model do
  context 'Association Test' do
    it 'has many posts' do
      expect(User.reflect_on_association(:posts).macro).to be :has_many
    end

    it 'has many comments ' do
      expect(User.reflect_on_association(:comments).macro).to be :has_many
    end

    it 'has many likes' do
      expect(User.reflect_on_association(:likes).macro).to be :has_many
    end

    it 'has many friendships' do
      expect(User.reflect_on_association(:friendships).macro).to be :has_many
    end

    it 'has many to reverse friendships' do
      expect(User.reflect_on_association(:reverse_friendships).macro).to be :has_many
    end

    it 'has many friends' do
      expect(User.reflect_on_association(:friends).macro).to be :has_many
    end

    it 'has many unresolved request' do
      expect(User.reflect_on_association(:unresolved_request).macro).to be :has_many
    end

    it 'has many friend request' do
      expect(User.reflect_on_association(:friend_requests).macro).to be :has_many
    end
  end
end
