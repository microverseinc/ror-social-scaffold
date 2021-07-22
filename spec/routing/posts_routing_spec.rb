require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  it { should route(:get, '/').to(action: :index) }
end
