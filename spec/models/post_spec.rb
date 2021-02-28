require_relative '../rails_helper'

RSpec.describe Post do
  context 'validations' do
    it { should validate_presence_of(:content) }
    let(:user) do
      User.create!(name: 'test',
                   email: 'a@a.com',
                   password: '123456',
                   password_confirmation: '123456')
    end
    subject { Post.new(user: user) }
    it {
      should validate_length_of(:content)
        .is_at_most(1000)
        .with_message('1000 characters in post is the maximum allowed.')
    }
  end

  context 'assosciations' do
    it { should belong_to(:user).class_name('User') }
    it { should have_many(:comments).class_name('Comment').dependent(:destroy) }
    it { should have_many(:likes).class_name('Like').dependent(:destroy) }
  end
end
