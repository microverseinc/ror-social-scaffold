require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'Valid' do
    message = '200 characters in comment is the maximum allowed.'
    it { should validate_presence_of(:content) }
    it {
      should validate_length_of(:content).is_at_most(200).with_message(message)
    }
    body = (0..200).map { ('a'..'z').to_a[rand(26)] }.join

    it { should_not allow_value(body).for(:content) }
  end
  describe 'Comment' do
    it { should belong_to :user }
    it { should belong_to :post }
  end
end
