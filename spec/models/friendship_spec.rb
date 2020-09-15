require 'rails_helper'

RSpec.describe Friendship, type: :model do
  context 'Validation' do
    it { expect(subject).to have_db_column(:status).of_type(:string).with_options(default: 'requested') }
  end

  context 'Association' do
    it { expect(subject).to belong_to(:user) }
  end
end
