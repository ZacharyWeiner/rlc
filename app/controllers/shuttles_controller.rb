class ShuttlesController < ApplicationController
  before_action :set_shuttle, only: [:show, :edit, :update, :destroy]
  layout 'shuttle_layout'
  # GET /shuttles
  # GET /shuttles.json
  def index
    @shuttles = Shuttle.all
    # @lat = request.location.latitude
    # @long = request.location.longitude

     @ordered_shuttles = Shuttle.near([40.483387, -106.829826], 20)
     @ordered_shuttle_stops = ShuttleStop.near([40.483387, -106.829826], 20)
  end

  # GET /shuttles/1
  # GET /shuttles/1.json
  def show
    @ride_requests = @shuttle.ride_requests.where.not(completed: true)
  end

  # GET /shuttles/new
  def new
    @shuttle = Shuttle.new
  end

  # GET /shuttles/1/edit
  def edit
  end

  # POST /shuttles
  # POST /shuttles.json
  def create
    @shuttle = Shuttle.new(shuttle_params)

    respond_to do |format|
      if @shuttle.save
        format.html { redirect_to @shuttle, notice: 'Shuttle was successfully created.' }
        format.json { render :show, status: :created, location: @shuttle }
      else
        format.html { render :new }
        format.json { render json: @shuttle.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shuttles/1
  # PATCH/PUT /shuttles/1.json
  def update
    respond_to do |format|
      if @shuttle.update(shuttle_params)
        format.html { redirect_to @shuttle, notice: 'Shuttle was successfully updated.' }
        format.json { render :show, status: :ok, location: @shuttle }
      else
        format.html { render :edit }
        format.json { render json: @shuttle.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shuttles/1
  # DELETE /shuttles/1.json
  def destroy
    @shuttle.destroy
    respond_to do |format|
      format.html { redirect_to shuttles_url, notice: 'Shuttle was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def shuttle_locations
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shuttle
      @shuttle = Shuttle.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shuttle_params
      params.require(:shuttle).permit(:current_lat, :current_long, :previous_lat, :previous_long, :name, :address)
    end
end
