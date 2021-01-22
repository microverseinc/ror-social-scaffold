require 'rails_helper'

RSpec.describe Friendship, type: :model do
  let(:user1) { User.create!(name: 'test', email: 'test@test.com', password: '123456', encrypted_password: '123456') }
  let(:user2) { User.create!(name: 'test2', email: 'test2@test.com', password: '123456', encrypted_password: '123456') }

  context 'Assosiations' do
    it { should belong_to(:user) }
    it { should belong_to(:friend) }
  end
end
