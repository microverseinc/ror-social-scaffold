require_relative '../rails_helper'

# rubocop:disable Metrics/BlockLength

RSpec.describe User, type: :model do
  context 'creating user' do
    it 'name cannot be blank ' do
      expect { User.create! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  context 'User can create content' do
    let(:user) { User.create(name: 'Jar Jar', email: '123@email.com', password: '123456') }
    let(:post) { Post.create(content: 'Bla bla', user_id: user.id) }
    let(:comment) { Comment.create(content: 'Test', post_id: post.id, user_id: user.id) }
    it 'post have content Bla bla' do
      expect(post.content).to eql('Bla bla')
    end
    it 'comment has text Test' do
      expect(comment.content).to eql('Test')
    end
  end

  context 'testing associations' do
    it 'should have many posts' do
      u = User.reflect_on_association(:posts)
      expect(u.macro).to eq(:has_many)
    end
    it 'should have many comments' do
      u = User.reflect_on_association(:comments)
      expect(u.macro).to eq(:has_many)
    end
    it 'should have many likes' do
      u = User.reflect_on_association(:likes)
      expect(u.macro).to eq(:has_many)
    end
    it 'should have many friendships' do
      u = User.reflect_on_association(:friendships)
      expect(u.macro).to eq(:has_many)
    end
    it 'should have many inverse friendships' do
      u = User.reflect_on_association(:inverse_friendships)
      expect(u.macro).to eq(:has_many)
    end
  end

  context 'user methods' do
    let(:frodo) { User.create(name: 'Frodo', email: 'frodo@email.com', password: '123456') }
    let(:bilbo) { User.create(name: 'Bilbo', email: 'bilbo@email.com', password: '123456') }
    let(:gandalf) { User.create(name: 'Gandalf', email: 'gandalf@email.com', password: '123456') }
    let(:friendship_1) { Friendship.create(user_id: frodo.id, friend_id: bilbo.id, status: true) }
    let(:friendship_2) { Friendship.create(user_id: frodo.id, friend_id: gandalf.id, status: false) }

    it 'returns an array of user who are already friends' do
      frodo
      bilbo
      friendship_1
      expect(frodo.friends).to include(bilbo)
    end

    it 'returns an array of user who are friends to be accepted or rejected' do
      frodo
      gandalf
      friendship_2
      expect(frodo.pending_friends).to include(gandalf)
    end

    it 'returns an array of users who have requested to be friends' do
      frodo
      gandalf
      friendship_2
      expect(gandalf.friend_requests).to include(frodo)
    end

    it 'confirms user as a friend' do
      frodo
      gandalf
      bilbo
      friendship_2
      gandalf.confirm_friend(frodo)

      expect(gandalf.confirm_friend(frodo)).to eql(true)
    end

    it 'checks if user is a friend' do
      frodo
      gandalf
      bilbo
      friendship_1

      expect(frodo.friend?(bilbo)).to eql(true)
    end

    it 'returns post if post was written by user or a friend' do
      frodo
      gandalf
      bilbo
      friendship_1
      bilbo_post = bilbo.posts.create(content: 'Test')

      expect(frodo.friends_post(bilbo).first.content).to include(bilbo_post.content)
    end
  end
  # rubocop:enable Metrics/BlockLength
end
