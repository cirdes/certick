class GenerateController < ApplicationController
	before_action :set_certified, only: [:new, :create, :show]


	# GET /generate/1
  # GET /generate/1.json
  def new
  	@certified
    @certified.event = find_event @certified.event_id
  end

  # POST /generate
  # POST /generate.json
  def create
    #logger.info "Token for user #{@certified.user.email}: #{@certified.user.token}"

    attendees = SimpleEventickApi::Attendee.all @certified.user.token, @certified.event_id

    @attendee = attendees.select { |x| x.email == params[:email] }.first

    if @attendee != nil
      logger.info "Attendee name is #{@attendee.name}"
      render 'result' , layout: false
    elsif
      logger.info "Attendee not found"
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

    def find_event id
      SimpleEventickApi::Event.find current_user.token, id
    end
end
