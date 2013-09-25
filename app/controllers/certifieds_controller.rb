class CertifiedsController < ApplicationController
  before_action :set_certified, only: [:show, :edit, :update, :destroy]

  # GET /certifieds
  # GET /certifieds.json
  def index
    @certifieds = Certified.all
  end

  # GET /certifieds/1
  # GET /certifieds/1.json
  def show
  end

  # GET /certifieds/new
  def new

    # Eventick.config do |c|
    #   c.email = 'gporpino@gmail.com'
    #   c.password = 'nig231285'
    # end

    # @events = Eventick::Event.all

    @events = Array.new
    5.times  do |i|
      event = Eventick::Event.new

      event.title = 'teste' + i.to_s

      @events << event 
    end

    @certified = Certified.new
    @certified.slug = generate_token
  end

  # GET /certifieds/1/edit
  def edit
  end

  # POST /certifieds
  # POST /certifieds.json
  def create
    @certified = Certified.new(certified_params)

    respond_to do |format|
      if @certified.save
        format.html { redirect_to @certified, notice: 'Certified was successfully created.' }
        format.json { render action: 'show', status: :created, location: @certified }
      else
        format.html { render action: 'new' }
        format.json { render json: @certified.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /certifieds/1
  # PATCH/PUT /certifieds/1.json
  def update
    respond_to do |format|
      if @certified.update(certified_params)
        format.html { redirect_to @certified, notice: 'Certified was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @certified.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /certifieds/1
  # DELETE /certifieds/1.json
  def destroy
    @certified.destroy
    respond_to do |format|
      format.html { redirect_to certifieds_url }
      format.json { head :no_content }
    end
  end

  protected

    def generate_token
      token = loop do
        random_token = SecureRandom.urlsafe_base64(nil, false)
        break random_token unless Certified.where(slug: random_token).exists?
      end
    end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_certified
      @certified = Certified.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def certified_params
      params.require(:certified).permit(:slug, :background)
    end
end