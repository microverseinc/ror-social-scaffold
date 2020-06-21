module UsersHelper
  # rubocop:disable Style/InverseMethods
  def all_users
    users = User.select { |x| x.id != current_user.id }
    users
  end
  # rubocop:enable Style/InverseMethods
end
