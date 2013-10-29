class RetweetsController < ApplicationController
  before_filter :authenticate_user!

  # POST /retweets
  #
  # This action attempts to create a new retweet instance for the Tweet whose id matches
  # params[:retweet][:tweet_id]. If the retweet is created successfully, a success notice
  # is set. Otherwise, an error notice is set. #smart_return is used to redirect appropriately.
  #
  def create
    rt = current_user.retweets.create(retweet_params)
    if rt.valid? and rt.persisted?
      flash[:success] = "You retweeted: #{rt.tweet.content}"
    else
      flash[:error] = "We're sorry. You are unable to retweet that post."
    end
    smart_return
  end

  # DELETE /retweets/:id
  #
  # Responsible for un-retweeting. Works by deleting the Retweet instance. The use of the
  # resource method (defined below) ensures that only retweets which belong to the authenticated
  # user can be matched and deleted. If the Retweet instance is not found or deleted successfully,
  # an error notice is set. #smart_return is used to redirect appropriately.
  #
  def destroy
    if resource.exists?
      resource.destroy_all
    else
      flash[:error] = "We're sorry. We could not find that retweet."
    end
    smart_return
  end

  private

  # Finds a retweet instance that matches the id passed and assigns it to @resource
  # unless @resource is already assigned.
  #
  def resource
    @resource ||= current_user.retweets.where(:id => params[:id])
  end

  # http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  # This method uses Strong Parameters to ensure that the data passed by the user
  # is appropriate. If params[:retweet] does not exist or contains any key / value
  # pairs other then :tweet_id, an error will be raised and the page will return
  # a 400 'Bad Request' HTML response code.
  #
  def retweet_params
    params.require(:retweet).permit(:tweet_id)
  end

  # Leverages the params[:return_to] value to direct the user back to a requested
  # page. If no value is present, the user is directed back to the root path.
  #
  def smart_return
    if params[:return_to].present?
      redirect_to params[:return_to]
    else
      redirect_to root_path
    end
  end
end
