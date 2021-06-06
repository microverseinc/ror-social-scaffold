require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'Associations' do
    it { should belong_to(:user).class_name('User') }
    it { should belong_to(:post).class_name('Post') }
  end
end
