require 'rails_helper'

RSpec.describe Post do
  let(:test_user) { User.create(name: 'User', email: 'user@user.com', password: '123456') }
  let(:subject) { described_class.new(content: 'This is some content', user_id: test_user.id) }

  describe 'validations' do
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end
  end

  describe 'associations', type: :model do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:comments) }
    it { is_expected.to have_many(:likes) }
  end
end
