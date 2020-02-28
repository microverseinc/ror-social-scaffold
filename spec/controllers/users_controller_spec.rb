require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) do
    User.create(
      name: 'john',
      email: 'john@gmail.com',
      password: 'password'
    )
  end

  it 'action INDEX should redirect us do sign in page if not logged in' do
    get :index
    expect(response).to redirect_to(new_user_session_path)
  end

  it 'action INDEX should render index template if user is logged in' do
    sign_in(user, scope: :user)
    get :index
    expect(response).to render_template('users/index')
  end

  it 'action SHOW should redirect us do sign in page if not logged in' do
    get :show, params: { id: user.id }
    expect(response).to redirect_to(new_user_session_path)
  end

  it 'action SHOW should render show template if user is logged in' do
    sign_in(user, scope: :user)
    get :show, params: { id: user.id }
    expect(response).to render_template('users/show')
  end
end
