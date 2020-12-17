require 'rails_helper'

RSpec.describe Like, type: :model do
  it 'Belongs to user' do
    w = Like.reflect_on_association(:user)
    expect(w.macro).to eq(:belongs_to)
  end

  it 'Belongs to post' do
    w = Like.reflect_on_association(:post)
    expect(w.macro).to eq(:belongs_to)
  end

  context 'Validation test for Likes model' do
    like_f = Like.create(post_id: 1, user_id: 1)

    it 'User not like two times the same post' do
      like_r = Like.new(post_id: 1, user_id: 1)
      expect(like_r.valid?).to be false
    end
  end
end
