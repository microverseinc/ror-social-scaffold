require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe 'Friendship' do
    let(:user1) do
      User.create(name: 'Test1',
                  email: 'test1@email.com',
                  password: 'password',
                  password_confirmation: 'password')
    end

    let(:user2) do
      User.create(name: 'Test2',
                  email: 'test2@email.com',
                  password: 'password',
                  password_confirmation: 'password')
    end

    let(:friend_request) { Friendship.create(requester_id: user1.id, confirmer_id: user2.id) }

    it 'belongs_to user' do
      expect(friend_request).to eq(user2.friendships.first)
    end
  end

  describe 'Custom Validation tests' do
    subject { Friendship.new }
    let(:requester) do
      User.create(name: 'Test1',
                  email: 'test1@email.com',
                  password: 'password',
                  password_confirmation: 'password')
    end

    let(:confirmer) do
      User.create(name: 'Test2',
                  email: 'test2@email.com',
                  password: 'password',
                  password_confirmation: 'password')
    end

    it 'validates against duplicate friendship' do
      requester.friendships.new(requester: confirmer).save
      subject.requester = requester
      subject.confirmer = confirmer
      error_message = 'Validation failed: This relationship already exists'
      expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid, error_message)
    end

    it 'validates against duplicate inverse-friendship' do
      confirmer.inverse_friendships.new(confirmer: requester).save
      subject.requester = requester
      subject.confirmer = confirmer
      error_message = 'Validation failed: This relationship already exists'
      expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid, error_message)
    end

    it 'validates against self-friendship' do
      subject.requester = requester
      subject.confirmer = requester
      expect { subject.save! }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end

  describe 'Associations' do
    it { should belong_to(:requester).class_name('User') }

    it { should belong_to(:confirmer) }
  end
end
