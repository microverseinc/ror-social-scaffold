describe User, type: :model do
  let(:user) { User.create(name: 'elisha', email: 'elisha@gmail.com', password: 'elishapassword') }
  it 'is valid with valid attributes' do
    expect(user).to be_valid
  end

  it 'is not valid without a name' do
    user.name = nil
    expect(user).to_not be_valid
  end

  context 'validations' do
    it 'presence' do
      user.email = nil
      expect(user).to_not be_valid
    end

    it 'uniqueness' do
      User.create(name: 'elisha', email: 'elisha@gmail.com', encrypted_password: 'elishapassword')
      user2 = User.create(name: 'elisha', email: 'elisha@gmail.com', encrypted_password: 'elishapassword')
      expect(user2).to_not be_valid
    end

    it 'is database authenticable' do
      user = User.create(
        email: 'test@example.com',
        password: 'password123',
        password_confirmation: 'password123'
      )
      expect(user.valid_password?('password123')).to be_truthy
    end
  end
end
