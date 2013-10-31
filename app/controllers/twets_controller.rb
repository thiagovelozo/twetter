class TwetsController < ApplicationController
  # All actions in this controller require the presence of an authenticated user.
  before_filter :authenticate_user!

  # GET /twets
  #
  # This action uses the #get_twets method to set the @twets instance variable.
  #
  #   @twets # => All twets defaultly shown to the authenticated user.
  #
  def index
    get_twets
  end

  # POST /twets
  #
  # Used to create a new twet for the authenticated user based on the data passed
  # in params[:twet]. If the twet is created successfully, a success message is
  # set and we are directed to the index action. Otherwise, an error message is set,
  # the twets visible to the authenticated user are loaded into @twets and the index
  # view template is displayed.
  #
  #   @twet # => The newly created (or attempted) twet.
  #   @twets # => (only set if the twet was not created) All twets defaultly shown
  #                to the authenticated user.
  #
  #
  def create
    @twet = current_user.twets.create(twet_params)
    if @twet.valid?
      flash[:success] = "Your twet was shared"
      redirect_to :action => :index and return
    else
      get_twets
      flash[:error] = "Your twet could not be saved"
      render :action => :index and return
    end
  end

  private

  # Sets the @twets instance variable to all twets viewable by the current user
  def get_twets
    if params[:username]
      @user = User.where(:username => params[:username]).first
      @twets = Twet.by_user_ids(@user.id) if @user
    else
      @twets = current_user.all_twets
    end
  end

  # http://guides.rubyonrails.org/action_controller_overview.html#strong-parameters
  #
  # This method uses Strong Parameters to ensure that the data passed by the user
  # is appropriate. If params[:twet] does not exist or contains any key / value
  # pairs other then :content, an error will be raised and the page will return
  # a 400 'Bad Request' HTML response code.
  #
  def twet_params
    params.require(:twet).permit(:content)
  end
end
