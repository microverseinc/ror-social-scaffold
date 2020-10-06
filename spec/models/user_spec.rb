require 'rails_helper'

RSpec.describe 'Model', type: :model do
  describe User do
    describe 'associations' do
      it { should have_many(:friendships) }
      it { should have_many(:inverse_friendships).class_name('Friendship') }
      it { should have_many(:posts) }
      it { should have_many(:likes) }
      it { should have_many(:comments) }
    end

    describe 'validations' do
      it { should validate_presence_of(:name) }
    end

    describe 'Class Method' do
      describe '#friends' do
        it 'should return an array' do
          expect(subject.friends).to be_instance_of Array
        end
      end

      describe '#pending_friends' do
        it 'should return an array' do
          expect(subject.pending_friends).to be_instance_of Array
        end
      end

      describe '#friend_requests' do
        it 'should return an array' do
          expect(subject.friend_requests).to be_instance_of Array
        end
      end
    end
  end
end