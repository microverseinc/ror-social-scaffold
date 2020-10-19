require 'rails_helper'

RSpec.describe Comment, type: :model do
  context "Validation test" do
    it 'cannot be empty' do
      comm = Post.new(content: '').save
      expect(comm).to eq(false)
    end

    it 'maximum characters is 200' do
      comment = 't'*200
      comm0 = Post.new(content: comment).save
      expect(comm0).to eq(false)
    end

    it "must have a user and a post" do
        comm1 = Post.new(content:'must have a user and a post').save
        expect(comm1).to eq(false)
    end
  end
end
