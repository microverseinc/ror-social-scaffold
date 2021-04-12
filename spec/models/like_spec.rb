require 'rails_helper'

RSpec.describe Like, type: :model do
  # context 'Creating an Event' do
  #   it 'creates an event' do
  #     expect(event).to be_an Event
  #   end
  # end

  context 'Association test for Likes model' do
    it 'should belong to User' do
      t = Like.reflect_on_association(:user)
      expect(t.macro).to eq(:belongs_to)
    end
    it 'should belong to Post' do
      t = Like.reflect_on_association(:post)
      expect(t.macro).to eq(:belongs_to)
    end
  end

  context 'Validation test for Likes model' do
    let(:like) { Like.create(post_id: 1, user_id: 1) }

    it 'the same user should not like the same post twice' do
      t = Like.new(post_id: 1, user_id: 1)
      expect(t.valid?).to be false
    end
  end
end
