class ShuttlesController < ApplicationController
  before_action :set_shuttle, only: [:show, :edit, :update, :destroy]
  layout 'shuttle_layout'
  # GET /shuttles
  # GET /shuttles.json
  def index
    return redirect_to new_ride_request_path
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
    @ordered_stops = @shuttle.get_ordered_stops
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
        if params[:redirect]
          format.html { redirect_to assign_drivers_path, notice: 'Shuttle was successfully updated.' }
        end
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

  def driver
    @lat = request.location.latitude
    @long = request.location.longitude
  end

  def set_location
    set_shuttle
    puts @shuttle.id
    respond_to do |format|
      @shuttle.previous_lat = @shuttle.current_lat
      @shuttle.previous_long = @shuttle.current_long
      @shuttle.current_lat = params[:lat]
      @shuttle.current_long = params[:long]
      if @shuttle.save
        format.json { render json: "success", status: :success}
      else
        format.json { render json: "error", status: :unprocessable_entity}
      end

    end
  end

  def assign_drivers
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shuttle
      if params[:shuttle_id]
        @shuttle = Shuttle.find(params[:shuttle_id])
      else
        @shuttle = Shuttle.find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shuttle_params
      params.require(:shuttle).permit(:current_lat, :current_long, :previous_lat, :previous_long, :name, :address, :plate_number)
    end
end
