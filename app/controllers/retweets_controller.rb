class RetweetsController < ApplicationController
  before_filter :authenticate_user!

  def create
    rt = current_user.retweets.create(retweet_params)
    if rt.valid? and rt.persisted?
      flash[:success] = "You retweeted: #{rt.tweet.content}"
    else
      flash[:error] = "We're sorry. You are unable to retweet that post."
    end
    smart_return
  end

  def destroy
    if resource.exists?
      resource.destroy_all
    else
      flash[:error] = "We're sorry. We could not find that retweet."
    end
    smart_return
  end

  private

  def resource
    @resource ||= current_user.retweets.where(:id => params[:id])
  end
  def retweet_params
    params.require(:retweet).permit(:tweet_id)
  end

  def smart_return
    if params[:return_to].present?
      redirect_to params[:return_to]
    else
      redirect_to root_path
    end
  end
end
