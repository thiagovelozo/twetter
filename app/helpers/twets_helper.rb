module TwetsHelper

  # Returns true / false indicating whether the twet passed can be
  # retweted by the authenticated user.
  #
  def can_retwet(twet)
    if twet.user_id == current_user.id
      return false
    elsif has_retweted(twet)
      return false
    else
      return true
    end
  end

  # Returns true / false indicating whether the authenticated user
  # has already retweted the twet passed.
  #
  def has_retweted(twet)
    retwet(twet).present? ? true : false
  end

  # Returns the actual retwet instance created by the authenticated user for
  # the twet passed
  #
  def retwet(twet)
    current_user.retwets.where(:twet_id => twet.id).first
  end
end
