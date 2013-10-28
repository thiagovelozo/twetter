class RetweetsController < ApplicationController
  before_filter :authenticate_user!

  def create
    rt = current_user.retweets.create(retweet_params)
    if rt.valid? and rt.persisted?
      flash[:success] = "You retweeted: #{rt.tweet.content}"
    else
      flash[:error] = "We're sorry. You are unable to retweet that post."
    end
    redirect_to params[:return_to] || root_path
  end

  def destroy
    rt = Retweet.where(:id => params[:id])
    if rt.exists?
      rt.destroy_all
    else
      flash[:error] = "We're sorry. We could not find that retweet."
    end
    redirect_to params[:return_to] || root_path
  end

  private

  def retweet_params
    params.require(:retweet).permit(:tweet_id)
  end

end
