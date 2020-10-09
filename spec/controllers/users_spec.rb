require 'rails_helper'

RSpec.describe UsersController do
  context 'Actions' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
    it 'renders the show template' do
      get :show
      expect(response).to render_template('show')
    end
  end
end
