require 'rails_helper'



RSpec.describe User, type: :model do
   user =  User.create(id: '1', name: 'Wilmer', email: 'wamg@gmail.com', password: '123456')
   
    context 'Signup new user' do

      it ' Equal to user name' do
        expect(user.name).to eq('Wilmer')
      end
      it 'Not to equal to a wrong user name' do
        expect(user.name).not_to eql('Alexis')
      end

      it 'Equal to user email' do
        expect(user.email).to eq('wamg@gmail.com')
      end

      it 'Not equal to user email' do
        expect(user.email).not_to eq('wrong@gmail.com')
      end

      it 'Equal to user id' do
        expect(user.id).to eq(1)
      end

      it 'Not equal to user id' do
        expect(user.id).not_to eq('wrong')
      end

      it 'Equal to user password' do
        expect(user.password).to eq('123456')
      end

      it 'Not equal to user password' do
        expect(user.password).not_to eq('wrong_password')
      end

    end

    context 'Associations' do
        it 'Have many Posts' do
            have_many(:posts)
        end
        it 'Have many Friends' do
            have_many(:friendships)
        end
        it 'Have many comments' do
            have_many(:comments)
        end
        it 'Have many Likes' do
            have_many(:likes)
        end
    end
end