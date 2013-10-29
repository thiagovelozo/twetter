class TweetsController < ApplicationController
  # All actions in this controller require the presence of an authenticated user.
  before_filter :authenticate_user!

  # GET /tweets
  #
  # This action uses the #get_tweets method to set the @tweets instance variable.
  #
  #   @tweets # => All tweets defaultly shown to the authenticated user.
  #
  def index
    get_tweets
  end

  # POST /tweets
  #
  # Used to create a new tweet for the authenticated user based on the data passed
  # in params[:tweet]. If the tweet is created successfully, a success message is
  # set and we are directed to the index action. Otherwise, an error message is set,
  # the tweets visible to the authenticated user are loaded into @tweets and the index
  # view template is displayed.
  #
  #   @tweet # => The newly created (or attempted) tweet.
  #   @tweets # => (only set if the tweet was not created) All tweets defaultly shown
  #                to the authenticated user.
  #
  #
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

  # Sets the @tweets instance variable to all tweets viewable by the current user
  def get_tweets
    @tweets = current_user.all_tweets
  end

  # http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  # This method uses Strong Parameters to ensure that the data passed by the user
  # is appropriate. If params[:tweet] does not exist or contains any key / value
  # pairs other then :content, an error will be raised and the page will return
  # a 400 'Bad Request' HTML response code.
  #
  def tweet_params
    params.require(:tweet).permit(:content)
  end
end
