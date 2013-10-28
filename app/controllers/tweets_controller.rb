class TweetsController < ApplicationController
  before_filter :authenticate_user!

  def index
    get_tweets
  end

  def create
    @tweet = current_user.tweets.create(tweet_params)
    if @tweet.valid?
      flash[:success] = "Your tweet was shared"
      redirect_to :action => :index and return
    else
      get_tweets
      flash[:error] = "Your tweet could not be saved"
      render :action => :index and return
    end
  end

  private

  def get_tweets
    if params[:username]
      user = User.where(:username => params[:username]).first
      @tweets = user.tweets.order('created_at DESC') if user
    else
      @tweets = current_user.all_tweets
    end
  end

  def tweet_params
    params.require(:tweet).permit(:content)
  end
end
