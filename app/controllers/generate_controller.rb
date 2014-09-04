class GenerateController < ApplicationController
	before_action :set_certified, only: [:new, :create, :show]


	# GET /generate/1
  # GET /generate/1.json
  def new
  	@certified
  end

  # POST /generate
  # POST /generate.json
  def create
    attendee = @certified.attendees[params[:email]]

    if attendee
			@name = attendee.upcase
      render 'result', layout: false
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
end
