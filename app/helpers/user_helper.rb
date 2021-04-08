module UserHelper
  def display_errors(user)
    return unless user.errors.full_messages.any?

    content_tag :p, "User could not be created. #{user.errors.full_messages.join('. ')}", class: 'errors'
  end

  def add_friend
    
  end
end