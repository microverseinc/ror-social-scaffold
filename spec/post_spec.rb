require 'rails_helper'

RSpec.describe Post, type: :model do
  describe 'Associations' do
    it { should have_many(:comments) }
    it { should have_many(:likes) }
    it { should belong_to(:user).class_name('User') }
  end
end

RSpec.describe Post, type: :model do
  subject do
    User.create(id: 4, name: 'Marco', email: 'mrigorir@.com', password: 'qweqwe')
    Post.new(content: 'Lure', user_id: 4)
  end

  it 'is valid with content length and a user_id(user logged in)' do
    expect(subject).to be_valid
  end

  it 'is not valid without a description' do
    subject.content = nil
    expect(subject).to_not be_valid
  end
end
