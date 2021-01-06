require 'rails_helper'

RSpec.describe User do
  let(:subject) do
    described_class.new(
      name: 'example',
      email: 'example@example.com',
      password: '123456'
    )
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:password) }
    it 'is valid with valid attributes' do
      expect(subject).to be_valid
    end
    it 'The name of the user should exist' do
      subject.name = ''
      expect(subject).not_to be_valid
    end
    it 'The email of the user should exist' do
      subject.email = ''
      expect(subject).not_to be_valid
    end
  end
  describe 'Associations', type: :model do
    it { is_expected.to have_many(:posts) }
    it { is_expected.to have_many(:comments) }
    it { is_expected.to have_many(:likes) }
    it { is_expected.to have_many(:confirmed_friendships) }
    it { is_expected.to have_many(:pending_friendships) }
    it { is_expected.to have_many(:inverted_friendships) }
  end
end
