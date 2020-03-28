require 'rails_helper'

RSpec.describe User, type: :model do
  

  it 'is valid with a name' do
    name = 'Foo Bar'
    email = 'Foo@Bar'
    password = 'FooBar'
    #expect User to be_valid
  end

  it 'is not valid without a name' do
    name = ''
    
  end
end
