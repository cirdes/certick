class GenerateController < ApplicationController
	before_action :set_certified, only: [:new, :create, :show]
	

	# GET /generate/1
  # GET /generate/1.json
  def new
  	
  	@certified
  end

	# GET /generate/1
  # GET /generate/1.json
  def show
    
    attendees = SimpleEventickApi::Attendee.all current_user.token, @certified.event_id
    
    @attendee = attendees.select { |x| x.email == params[:email] }.first
    
    

    if @attendee != nil
      @attendee 
    else
      redirect_to generate_new_url, notice: 'This user does not in roll list of event.'
    end
  end

  # POST /generate
  # POST /generate.json
  def create

    attendees = SimpleEventickApi::Attendee.all current_user.token, @certified.event_id
    
    @attendee = attendees.select { |x| x.email == params[:email] }.first

    if @attendee != nil
      render 'result' , layout: false
    elsif
      redirect_to generate_new_url(params), notice: 'This user does not in roll list of event.'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_certified
      @certified = Certified.where(slug: params[:slug]).first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def certified_params
      params.require(:certified).permit(:slug, :background)
    end

end
