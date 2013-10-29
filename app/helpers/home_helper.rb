module HomeHelper

  # Returns the authenticated user if one is logged in, or a blank new user if not.
  #
  def resource
    current_user || User.new
  end
end
