require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validations' do
    it 'is false when name is not assigned to user' do
      user = User.new
      expect(user.valid?).to be false
    end
  end

  context 'assosciations' do
    it { should have_many(:posts).class_name('Post') }
    it { should have_many(:likes).class_name('Like').dependent(:destroy) }
    it { should have_many(:comments).class_name('Comment').dependent(:destroy) }
    it { should have_many(:friendships) }
    it { should have_many(:friends).through(:confirmed_friendships) }
  end
end
