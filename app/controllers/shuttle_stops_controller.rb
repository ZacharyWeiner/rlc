class ShuttleStopsController < ApplicationController
  before_action :set_shuttle_stop, only: [:show, :edit, :update, :destroy]

  # GET /shuttle_stops
  # GET /shuttle_stops.json
  def index
    @shuttle_stops = ShuttleStop.all
  end

  # GET /shuttle_stops/1
  # GET /shuttle_stops/1.json
  def show
  end

  # GET /shuttle_stops/new
  def new
    @shuttle_stop = ShuttleStop.new
  end

  # GET /shuttle_stops/1/edit
  def edit
  end

  # POST /shuttle_stops
  # POST /shuttle_stops.json
  def create
    @shuttle_stop = ShuttleStop.new(shuttle_stop_params)

    respond_to do |format|
      if @shuttle_stop.save
        format.html { redirect_to @shuttle_stop, notice: 'Shuttle stop was successfully created.' }
        format.json { render :show, status: :created, location: @shuttle_stop }
      else
        format.html { render :new }
        format.json { render json: @shuttle_stop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /shuttle_stops/1
  # PATCH/PUT /shuttle_stops/1.json
  def update
    respond_to do |format|
      if @shuttle_stop.update(shuttle_stop_params)
        format.html { redirect_to @shuttle_stop, notice: 'Shuttle stop was successfully updated.' }
        format.json { render :show, status: :ok, location: @shuttle_stop }
      else
        format.html { render :edit }
        format.json { render json: @shuttle_stop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shuttle_stops/1
  # DELETE /shuttle_stops/1.json
  def destroy
    @shuttle_stop.destroy
    respond_to do |format|
      format.html { redirect_to shuttle_stops_url, notice: 'Shuttle stop was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shuttle_stop
      @shuttle_stop = ShuttleStop.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shuttle_stop_params
      params.require(:shuttle_stop).permit(:shuttle_id, :order, :address, :latitude, :longitude, :person_count)
    end
end
