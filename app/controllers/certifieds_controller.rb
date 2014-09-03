class CertifiedsController < ApplicationController
  before_action :set_certified, only: [:show, :edit, :update, :destroy]
  before_action :get_events, only: [:new, :edit]

  # GET /certifieds
  # GET /certifieds.json
  def index
    logger.info "get own certifieds."

    @certifieds = Certified.where(user: self.current_user)
    logger.info "consuming certifieds event from api."
    @certifieds.each { |c|
      c.event = find_event c.event_id
    }
  end

  # GET /certifieds/1
  # GET /certifieds/1.json
  def show
    @certified.event = find_event @certified.event_id
  end

  # GET /certifieds/1/edit
  def edit
    @certified.event = find_event @certified.event_id
  end

  # GET /certifieds/new
  def new
    @certified = Certified.new
    certifieds = Certified.where(:user => current_user)

    certifieds.each { |c|
      event = @events.select { |e| e.id == c.event_id }.first
      @events.delete event if event != nil
    }

    redirect_to certifieds_url, notice: "No events available to add a background. All your events already have background set." if @events.count == 0
  end

  # POST /certifieds
  # POST /certifieds.json
  def create
    @certified = Certified.new(certified_params)
    @certified.slug = generate_token
    @certified.user = self.current_user

    respond_to do |format|
      if @certified.save
        format.html { redirect_to @certified, notice: 'Certified was successfully created.' }
        format.json { render action: 'show', status: :created, location: @certified }
      else
        format.html {
          get_events
          redirect_to action: 'new'
        }
        format.json { render json: @certified.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /certifieds/1
  # PATCH/PUT /certifieds/1.json
  def update
    respond_to do |format|
      @certified.background_url = params[:background_url]

      if @certified.update(certified_params)
        format.html { redirect_to @certified, notice: 'Certified was successfully updated.' }
        format.json { head :no_content }
      else
        format.html {
          get_events
          render action: 'edit', alert: @certified.errors.to_a
        }
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
    params.require(:certified).permit( :background_url, :event_id, :name_color)
  end

  def get_events
    @events = SimpleEventickApi::Event.all current_user.token
  end

  def find_event id
    SimpleEventickApi::Event.find current_user.token, id
  end
end
