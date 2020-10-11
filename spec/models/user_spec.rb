require 'rails_helper'

RSpec.describe 'Model', type: :model do
  subject { User.create(name: 'user', email: 'user@email.domain', password: '12345pass') }
  let(:user1) { User.create(name: 'user1', email: 'user1@email.domain', password: '12345pass') }
  let(:user2) { User.create(name: 'user2', email: 'user2@email.domain', password: '12345pass') }

  describe User do
    describe 'associations' do
      it { should have_many(:friendships) }
      it { should have_many(:inverse_friendships).class_name('Friendship') }
      it { should have_many(:posts) }
      it { should have_many(:likes) }
      it { should have_many(:comments) }
      it { should have_many(:approved_friendships).class_name('Friendship') }
      it { should have_many(:approved_friends) }
      it { should have_many(:accepted_friendships).class_name('Friendship') }
      it { should have_many(:accepted_friends) }
      it { should have_many(:sent_friendships).class_name('Friendship') }
      it { should have_many(:pending_friends) }
    end

    describe 'validations' do
      it { should validate_presence_of(:name) }
    end

    describe 'Class Method' do
      describe '#friends' do
        it 'returns an array' do
          expect(subject.friends).to be_instance_of Array
        end
      end

      describe '#find_friendship' do
        it 'returns an array' do
          expect(subject.find_friendship(user1).to_a).to be_instance_of Array
        end
      end

      describe '#find_either_friendship' do
        it 'returns an array' do
          expect(subject.find_either_friendship(subject, user1).to_a).to be_instance_of Array
        end
      end

      describe '#friend?' do
        it 'returns true if two users are friends' do
          subject.friendships.create(invitee_id: user1.id, status: false).update(status: true)
          expect(subject.friend?(user1)).to eq true
        end

        it 'returns false if two users are not friends' do
          expect(subject.friend?(user2)).to eq false
        end
      end
    end
  end
end
