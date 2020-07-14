require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the UserHelper. For example:
#
# describe UserHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe UserHelper, type: :helper do
  let(:current_user) { create :user }
  let(:other_user) { create :user }
  let!(:friendship) { create :friendship, requester: current_user, receiver: other_user }

  context '#find_friendships' do
    it 'Finds the correct friendship passing the receiver' do
      found_friendship = find_friendship(other_user)
      expect(found_friendship).to eql(friendship)
    end
  end

  context '#friendship_interaction' do
    it 'returns nil if the user is the current_user' do
      expect(friendship_interaction(current_user)).to eql(nil)
    end
  end

  context 'Current user has received an invitation' do
    let!(:friendship) { create :friendship, requester: other_user, receiver: current_user }
    it 'Returns drop invitation message' do
      interaction = friendship_interaction(other_user)
      expect(interaction).to include('Accept Friendship')
      expect(interaction).to include('patch')
      expect(interaction).to include('Reject Friendship')
      expect(interaction).to include('delete')
    end
  end

  context 'Current user has sent an invitation' do
    let!(:friendship) { create :friendship, requester: current_user, receiver: other_user }
    it 'Returns drop invitation message' do
      interaction = friendship_interaction(other_user)
      expect(interaction).to include('Drop invitation')
      expect(interaction).to include('delete')
    end
  end

  context 'Current user and receiver are friends' do
    let!(:friendship) { create :friendship, requester: current_user, receiver: other_user, confirmed: true }
    it 'Returns unfriend message' do
      interaction = friendship_interaction(other_user)
      expect(interaction).to include('Unfriend')
      expect(interaction).to include('delete')
    end
  end

  context 'Current user and receiver are not related' do
    it 'Returns unfriend message' do
      friendship.destroy
      interaction = friendship_interaction(other_user)
      expect(interaction).to include('Invite friend')
      expect(interaction).to include('post')
    end
  end
end
