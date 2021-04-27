require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe Comment, type: :model do
    subject do
      User.create(id: 20, name: 'RandomName')
      Comment.new(content: 'Random DescriptionRandom',
                  date: DateTime.now,
                  user_id: 20)
    end
  end

  describe 'validations' do
    it { should validate_presence_of(:content) }
  end

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:post) }
  end
end
