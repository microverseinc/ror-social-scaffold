require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation content' do
    it 'ensures content presence' do
      comment = Comment.new(content: '').save
      expect(comment).to eql(false)
    end

    it 'should save successfully' do
      comment = Comment.new(content: "We've got something rolling").save
      expect(comment).to eql(false)
    end
  end
end
