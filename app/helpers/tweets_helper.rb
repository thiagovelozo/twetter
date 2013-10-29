module TweetsHelper
  def can_retweet(tweet)
    if tweet.user_id == current_user.id
      return false
    elsif has_retweeted(tweet)
      return false
    else
      return true
    end
  end

  def has_retweeted(tweet)
    retweet(tweet).present? ? true : false
  end

  def retweet(tweet)
    current_user.retweets.where(:tweet_id => tweet.id).first
  end
end
