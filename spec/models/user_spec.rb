require_relative '../rails_helper'

RSpec.describe User do
  context 'validations' do
    it 'is false when name is not assigned to user' do
      user = User.new
      expect(user.valid?).to be false
    end
  end

  context 'assosciations' do
    it { should have_many(:posts).class_name('Post') }
    it { should have_many(:likes).class_name('Like').dependent(:destroy) }
    it { should have_many(:comments).class_name('Comment').dependent(:destroy) }
    it { should have_many(:friendships).class_name('Friendship').with_foreign_key('recieved_friend_id') }
    it { should have_many(:recieved_friends).through(:friendships) }
  end
end
