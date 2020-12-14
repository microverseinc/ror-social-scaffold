require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'Association Test' do
    it 'has many comments' do
      expect(Post.reflect_on_association(:comments).macro).to be :has_many
    end

    it 'has many likes' do
      expect(Post.reflect_on_association(:likes).macro).to be :has_many
    end

    it 'belongs to users' do
      expect(Post.reflect_on_association(:user).macro).to be :belongs_to
    end
  end
end
