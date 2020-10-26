module FriendshipsHelper
  # Redirects to stored location.
  def redirect_back
    redirect_to(session[:forwarding_url])
    session.delete(:forwarding_url)
  end

  # Stores the URL trying to be accessed.
  def store_location
    session[:forwarding_url] = request.original_url
  end

  def format_stat(count, word)
    pluralize(count, word).split(' ')
  end
end
