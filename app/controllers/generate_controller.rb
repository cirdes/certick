class GenerateController < ApplicationController
	before_action :set_certified, only: [:show]
	

	# GET /generate/1
  # GET /generate/1.json
  def show
  	puts "teste de porpino #{@certified.to_yaml}"
  	@certified 
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
