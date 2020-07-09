require "rails_helper"

RSpec.describe User, type: :model do
  let(:current_user) { create :user }
  let(:user) { create :user }

  context "#friendable?" do
    it "validates if a user CAN be a friend to the current_user" do
      expected = user.friendable?(current_user)
      expect(expected).to be_truthy
    end
  end

  context "#unfriendable?" do
    let!(:friendship) { create :friendship, user_id: current_user.id, friend_id: user.id }
    it "validates if a user can be unfriend by the current user" do
      expected = user.unfriendable?(current_user)
      expect(expected).to be_truthy
    end
  end
end
