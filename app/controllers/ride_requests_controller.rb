class RideRequestsController < ApplicationController
  before_action :set_ride_request, only: [:show, :edit, :update, :destroy, :assign_to_shuttle, :mark_clear, :advance_status]
  layout 'shuttle_layout'
  #autocomplete :pickup_location, :name
  # GET /ride_requests
  # GET /ride_requests.json
  def index
    @ride_requests = RideRequest.all
  end

  # GET /ride_requests/1
  # GET /ride_requests/1.json
  def show
  end

  # GET /ride_requests/new
  def new
    # @lat = request.location.latitude
    # @long = request.location.longitude

    @lat = Location.first.latitude
    @long = Location.first.longitude

    @ordered_locations = Location.near([@lat, @long], 30)
    @ride_request = RideRequest.new
  end

  # GET /ride_requests/1/edit
  def edit
  end

  # POST /ride_requests
  # POST /ride_requests.json
  def create
    @ride_request = RideRequest.new(ride_request_params)
    @ride_request.status = "In Queue"
    @ride_request.completed = false
    respond_to do |format|
      if @ride_request.save
        byebug
        if params[:ride_request][:redirect]
          return redirect_to ride_request_manager_path
        end
        if @ride_request.shuttle.nil?
          format.html { redirect_to @ride_request, notice: 'Ride request was successfully created.' }
        else
          format.html { redirect_to @ride_request.shuttle, notice: 'Ride request was successfully created.' }
          format.json { render :show, status: :created, location: @ride_request }
        end
      else
        byebug
        if params[:ride_request][:redirect]
          flash[:notice] = @ride_request.errors.full_messages.to_sentence
          return redirect_to ride_request_manager_path
        end
        format.html { render :new }
        format.json { render json: @ride_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ride_requests/1
  # PATCH/PUT /ride_requests/1.json
  def update
    respond_to do |format|
      if @ride_request.update(ride_request_params)
        format.html { redirect_to @ride_request.shuttle, notice: 'Ride request was successfully updated.' }
        format.json { render :show, status: :ok, location: @ride_request }
      else
        format.html { render :edit }
        format.json { render json: @ride_request.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ride_requests/1
  # DELETE /ride_requests/1.json
  def destroy
    @ride_request.destroy
    respond_to do |format|
      format.html { redirect_to ride_requests_url, notice: 'Ride request was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def manager
    @lat = Location.first.latitude
    @long = Location.first.longitude
    @ride_requests = RideRequest.where.not(completed: true)
    @ride_request = RideRequest.new
    @ordered_locations = Location.near([@lat, @long], 30)
  end

  def assign_to_shuttle
    @shuttle = Shuttle.find(params[:shuttle_id])
    @ride_request.shuttle = @shuttle
    @ride_request.advance_status(@ride_request.status)
    respond_to do |format|
      if @ride_request.save
        format.html { redirect_to ride_request_manager_path, notice: 'Ride request was successfully assigned.' }
      else
        byebug
      end
    end
  end

  def advance_status

    @ride_request.advance_status(@ride_request.status)
    redirect_to ride_request_manager_path
  end

  def mark_clear
    @ride_request.advance_status(@ride_request.status)
    redirect_to ride_request_manager_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ride_request
      if params[:ride_request_id]
        @ride_request = RideRequest.find(params[:ride_request_id])
      else
        @ride_request = RideRequest.find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ride_request_params
      params.require(:ride_request).permit(:pickup_address, :dropoff_address, :riders, :requester_name, :shuttle_id, :completed, :phone)
    end
end
