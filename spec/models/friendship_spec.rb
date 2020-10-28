require 'rails_helper'

RSpec.describe Friendship do
  subject { Friendship.new }

  describe 'Validations' do
    it { is_expected.not_to be_valid }
  end
end
