class FollowsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @users = User.all_except(current_user)
  end

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

  def destroy
    if resource and resource.destroy
      flash[:success] = "You are no longer following @#{resource.following.username}"
    else
      flash[:error] = "Your attempt to unfollow was not successful"
    end
    smart_return
  end

  private

  def follow_params
    params.require(:follow).permit(:following_id)
  end

  def resource
    @resource ||= current_user.follows.where(:id => params[:id]).first
  end

  def smart_return
    if params[:return_to].present?
      redirect_to params[:return_to]
    else
      redirect_to :action => :index
    end
  end
end
