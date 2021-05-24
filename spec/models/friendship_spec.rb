require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe 'is associated to user(inviter) and user(invitee)' do
    it { should belong_to(:invitee) }
    it { should belong_to(:inviter) }
  end
end
