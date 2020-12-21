require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) do
    User.create(name: 'User test', email: 'user@gmai.com',
                password: 'secret', password_confirmation: 'secret')
  end
  subject do
    described_class.new(user_id: user.id, content: 'This is a test post.')
  end

  it 'validates the presence of the post content' do
    expect(subject).to be_valid
  end

  it 'is invalid when content is blank or empty' do
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
