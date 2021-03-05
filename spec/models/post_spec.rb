require 'rails_helper'

RSpec.describe 'Post', type: :model do
  it 'should have content to be valid' do
    user = User.create(name: 'Rose', email: 'rosesumba6@yahoo.mail', password: 'sertot')
    post = Post.create(content: 'I get so bored in the afternoon', user_id: user.id)
    expect(post).to be_valid
  end

  it 'should be invalid without content' do
    user = User.create(name: 'Rose', email: 'rosesumba6@yahoo.mail', password: 'sertot')
    post = Post.create(content: '', user_id: user.id)
    expect(post).not_to be_valid
  end

  describe 'associations' do
    it 'can have many comments' do
      post = Post.reflect_on_association(:comments)
      expect(post.macro).to eql(:has_many)
    end
    it 'can have many comments' do
      post = Post.reflect_on_association(:likes)
      expect(post.macro).to eql(:has_many)
    end
  end
end
