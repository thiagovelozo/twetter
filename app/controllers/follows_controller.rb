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
  # is set. Either way we are directed back to the index action.
  #
  def create
    following = current_user.follows.where(:following_id => follow_params[:following_id]).first ||
      current_user.follows.create(follow_params)
    if following.present? and following.persisted?
      flash[:success] = "You are following @#{following.following.username}"
    else
      flash[:error] = "Your attempt to follow was unsuccessful"
    end
    redirect_to :action => :index
  end

  # DELETE /follows/:id
  #
  # Responsible for unfollowing a user. Works by deleting the Follow instance. The use of the
  # resource method (defined below) ensures that only follows which belong to the authenticated
  # user can be matched and deleted. If the Follow instance is found and deleted successfully,
  # a success notice is set. Otherwise, an error notice is set. Either way we are directed back
  # to the index action.
  #
  def destroy
    if resource and resource.destroy
      flash[:success] = "You are no longer following @#{resource.following.username}"
    else
      flash[:error] = "Your attempt to unfollow was not successful"
    end
    redirect_to :action => :index
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

  def resource
    @resource ||= current_user.follows.where(:id => params[:id]).first
  end
end
