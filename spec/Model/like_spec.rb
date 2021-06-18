require 'rails_helper'

RSpec.describe Like, type: :model do 
     
  it 'belong to user' do
    t = Like.reflect_on_association(:user)
    expect(t.macro).to eq(:belongs_to)
  end

  it 'belong to post' do
    t = Like.reflect_on_association(:post)
    expect(t.macro).to eq(:belongs_to)
  end
  
end
