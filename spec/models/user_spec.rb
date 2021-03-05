require 'rails_helper'

RSpec.configure do |c|
  c.use_transactional_examples = false
  c.order = 'defined'
end

RSpec.describe 'User', type: :model do
    it 'is valid with a name,email and password' do
      user= User.new(name: 'Rose', email: 'rosesumba2@gmail.com', password: 'sertot')
      expect(user).to be_valid
    end
    it 'is invalid with a password of less than 6 characters' do
      user= User.create(name: 'Rose', email: 'rose3@gmail.com', password: 'serto')
      expect(user).not_to be_valid
    end
    it 'is invalid if an email has already been taken' do
      user= User.create(name: 'Tim', email: 'rose3@gmail.com', password: 'sertoi')
      expect(user).not_to be_valid
    end
    describe 'associations' do
      it 'can have many friendships' do
        user = User.reflect_on_association(:friendships)
        expect(user.macro).to eql(:has_many)
      end
      it 'can have many friendships' do
        user = User.reflect_on_association(:inverse_friendships)
        expect(user.macro).to eql(:has_many)
      end
    end
  end