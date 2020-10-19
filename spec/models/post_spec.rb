require 'rails_helper'

RSpec.describe Post, type: :model do
  context "Validation test" do
    it "must have a user" do
     post = Post.new(content:'must have a user').save
     expect(post).to eq(false)
    end
  end
end
