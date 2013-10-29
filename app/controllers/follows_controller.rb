class FollowsController < ApplicationController
  # All actions in this controller require the presence of an authenticated user.
  before_filter :authenticate_user!

  # GET /follows
  #
  #   @users # => All users except the currently logged in user.
  #
  def index
    @users = User.all_except(current_user)
  end

  # POST /follows
  #
  # This action first attempts to find an existing Follow instance between the current user and
  # the user whose id matches params[:follow][:following_id]. If one is not found, it is created.
  # If the Follow is created successfully, a success notice is set. Otherwise, an error notice
  # is set. The #smart_return method is called to take us back to the appropriate page.
  #
  def create
    following = current_user.follows.where(:following_id => follow_params[:following_id]).first ||
      current_user.follows.create(follow_params)
    if following.present? and following.persisted?
      flash[:success] = "You are following @#{following.following.username}"
    else
      flash[:error] = "Your attempt to follow was unsuccessful"
    end
    smart_return
  end

  # DELETE /follows/:id
  #
  # Responsible for unfollowing a user. Works by deleting the Follow instance. The use of the
  # resource method (defined below) ensures that only follows which belong to the authenticated
  # user can be matched and deleted. If the Follow instance is found and deleted successfully,
  # a success notice is set. Otherwise, an error notice is set. The #smart_return method is
  # called to take us back to the appropriate page.
  #
  def destroy
    if resource and resource.destroy
      flash[:success] = "You are no longer following @#{resource.following.username}"
    else
      flash[:error] = "Your attempt to unfollow was not successful"
    end
    smart_return
  end

  private

  # http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  # This method uses Strong Parameters to ensure that the data passed by the user
  # is appropriate. If params[:follow] does not exist or contains any key / value
  # pairs other then :following_id, an error will be raised and the page will return
  # a 400 'Bad Request' HTML response code.
  #
  def follow_params
    params.require(:follow).permit(:following_id)
  end

  # Finds a Follow instance that matches the id passed and assigns it to @resource
  # unless @resource is already assigned. This ensures that we only look for the
  # Follow instance until we find it the first time.
  #
  def resource
    @resource ||= current_user.follows.where(:id => params[:id]).first
  end

  # Leverages the params[:return_to] value to direct the user back to a requested
  # page. If no value is present, the user is directed back to the index.
  #
  def smart_return
    if params[:return_to].present?
      redirect_to params[:return_to]
    else
      redirect_to :action => :index
    end
  end
end
