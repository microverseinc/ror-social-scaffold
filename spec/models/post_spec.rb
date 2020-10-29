require 'rails_helper'

RSpec.describe Post, type: :model do

  # context 'Creating an Event' do
  #   it 'creates an event' do
  #     expect(event).to be_an Event
  #   end
  # end

  context 'Association test for Posts model' do
    it 'should belong to User' do
      t = Post.reflect_on_association(:user)
      expect(t.macro).to eq(:belongs_to)
    end
    it 'should have many comments' do
      t = Post.reflect_on_association(:comments)
      expect(t.macro).to eq(:has_many)
    end
    it 'should have many likes' do
      t = Post.reflect_on_association(:likes)
      expect(t.macro).to eq(:has_many)
    end
  end

  context 'Validations test for Post model' do
    it 'a post without content should not be valid' do
      t = Post.new(content: '')
      expect(t.valid?).to be false
    end
  end
end
