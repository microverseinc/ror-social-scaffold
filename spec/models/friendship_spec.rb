require_relative '../rails_helper'

RSpec.describe Friendship do
  context 'validations' do
  end

  context 'assosciations' do
    it { should belong_to(:send_friend).class_name('User') }
    it { should belong_to(:recieved_friend).class_name('User') }
  end
end
