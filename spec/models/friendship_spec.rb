require 'rails_helper'

RSpec.describe Friendship, type: :model do
  describe 'Friendship' do
    # User
    it { should belong_to(:user) }

    # Post
    it { should belong_to(:friend).class_name('User') }
  end
end
