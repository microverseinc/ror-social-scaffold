require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do
  expect(get_friends(user)).to eq(true)
end
