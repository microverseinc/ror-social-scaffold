require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.create(name: 'test_user', email: 'test_user@test.com', password: "123456", password_confirmation: "123456") }
  subject { described_class.new(user_id: user.id, content: "This is a post created for the purpose of testing the post model.") }

  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is invalid when content is blank' do
    subject.content = nil
    expect(subject).to_not be_valid
  end

  it 'is invalid when content length is more than 1000 character' do
    subject.content = 'a' * 1001
    expect(subject).to_not be_valid
  end

  describe 'Associations' do
    it { should belong_to(:user) }
    it { should have_many(:comments) }
    it { should have_many(:likes) }
  end
end
