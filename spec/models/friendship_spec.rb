require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe 'association' do
    it 'A friend belongs to user' do
      should belong_to(:user)
    end
    it 'A registered user can be a friend to another user ' do
      should belong_to(:friend).class_name(:User)
    end
  end
end
