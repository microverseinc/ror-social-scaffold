require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'validations' do
    subject(:post) { build(:post) }

    it { is_expected.to validate_presence_of(:content) }

    it { is_expected.to validate_length_of(:content).is_at_most(1000).with_message('1000 characters in post is the maximum allowed.') } # rubocop:disable Layout/LineLength
  end

  describe 'associations' do
    it { is_expected.to belong_to(:user) }

    it { is_expected.to have_many(:likes) }

    it { is_expected.to have_many(:comments) }
  end

  describe '::by_me' do
    it 'should list all the posts written by the user' do
      post = create(:post)

      expect(Post.includes(:user).by_me(post.user).map(&:id)).to match_array([post.id])
    end
  end

  describe '::by_my_friends' do
    it 'should list all the posts written by my friends' do
      user = create(:user)
      friend = create(:user)
      friend.send_friend_request_to(user)
      user.accept_friend_request_of(friend)
      post = create(:post, user: friend)

      expect(Post.includes(:user).by_my_friends(user).map(&:id)).to match_array([post.id])
    end
  end

  describe '::by_known_people' do
    it 'should list all the posts written by me and my friends' do
      user = create(:user)
      friend = create(:user)
      friend.send_friend_request_to(user)
      user.accept_friend_request_of(friend)
      post = create(:post, user: friend)
      another_post = create(:post, user: user)

      expect(Post.includes(:user).by_known_people(user).map(&:id)).to match_array([post.id, another_post.id])
    end
  end
end
