module TweetsHelper

  # Returns true / false indicating whether the tweet passed can be
  # retweeted by the authenticated user.
  #
  def can_retweet(tweet)
    if tweet.user_id == current_user.id
      return false
    elsif has_retweeted(tweet)
      return false
    else
      return true
    end
  end

  # Returns true / false indicating whether the authenticated user
  # has already retweeted the tweet passed.
  #
  def has_retweeted(tweet)
    retweet(tweet).present? ? true : false
  end

  # Returns the actual retweet instance created by the authenticated user for
  # the tweet passed
  #
  def retweet(tweet)
    current_user.retweets.where(:tweet_id => tweet.id).first
  end
end
