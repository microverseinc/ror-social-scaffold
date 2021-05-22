
require 'rails_helper'

RSpec.describe Post, type: :model do
  it 'should validate length' do
    should validate_length_of (:content)
      .is_at_most(1000)
      .with_message('1000 characters in post id the maximum allowed.')
  end
  it 'should save new post successfully' do
    post1 = Post.new(content: 'soft vibes', user_id: 1).save
    expect(post1) == true
  end

end 