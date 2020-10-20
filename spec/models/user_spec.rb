require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate presence_of(:name) }
  end
end
