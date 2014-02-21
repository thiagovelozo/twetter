class UsersController < Devise::SessionsController
  before_filter :fetch_user, only: :show
  
  def show
  end
  
  def create
    super
  end
  
  def update
  end
  
  private
  def fetch_user
    if params[:username]
       @user = User.find_by_username(params[:username])
    else
       @user = User.find(params[:id])
    end
  end
end