require  'rails_helper'

RSpec.describe Post, type: :model do
    context 'Associations' do
        it 'Belongs to User' do
            w = Like.reflect_on_association(:user)
            expect(w.macro).to eql(:belongs_to)
        end

        it 'Has many likes' do
            have_many(:likes)
        end

        it 'Has many comments' do
            have_many(:comments)
        end
    end

    context 'Post model validation' do
        it 'Post model content' do
            post = Post.new(content:'contenido')
            expect(post.content).to eql('contenido')
        end

        it 'Post must not be empty' do
            post = Post.new(content:'')
            expect(post.valid?).to be false
        end
    end
end
