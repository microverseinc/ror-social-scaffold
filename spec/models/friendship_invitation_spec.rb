require 'rails_helper'

RSpec.describe FriendshipInvitation, type: :model do
  context 'Associations' do
    it { should belong_to(:inviter) }
    it { should belong_to(:invitee) }
  end
end
