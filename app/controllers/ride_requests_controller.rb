class RideRequestsController < ApplicationController
  before_action :set_ride_request, only: [:show, :edit, :update, :destroy, :assign_to_shuttle, :mark_clear, :advance_status, :reset_status]
  before_action :authenticate_user!, except: [:new, :create, :show, :edit, :update, :set_rider_info]
  layout 'shuttle_layout'
  #autocomplete :pickup_location, :name
  # GET /ride_requests
  # GET /ride_requests.json
  def index
    return redirect_to new_ride_request_path
    @ride_requests = RideRequest.all
  end

  # GET /ride_requests/1
  # GET /ride_requests/1.json
  def show
  end

  # GET /ride_requests/new
  def new
    @lat = session[:latitude]
    @long = session[:longitude]
    if @lat.nil?
      @ordered_locations = Location.all
    else
      @ordered_locations = Location.near([@lat, @long], 30)
    end
    @ride_request = RideRequest.new
  end

  # GET /ride_requests/1/edit
  def edit
  end

  # POST /ride_requests
  # POST /ride_requests.json
  def create
    @ride_request = RideRequest.new(ride_request_params)
    if ride_request_params[:shuttle_id] == "-- Please Select --"
      @ride_request.shuttle = nil
    end
    @ride_request.status = "In Queue"
    @ride_request.completed = false
    if session[:name]
      @ride_request.requester_name = session[:name]
    end
    if session[:phone]
      @ride_request.phone = session[:phone]
    end
    respond_to do |format|
      if @ride_request.save
        unless @ride_request.shuttle.nil?
          @ride_request.advance_status(@ride_request.status)
        end
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
    if @ride_request.status != "In Queue"
      return format.html { redirect_to @ride_request, notice: 'Ride cant be updated after the shuttle has been dispatched.' }
    end
    respond_to do |format|
      if @ride_request.update(ride_request_params)
        if @ride_request.shuttle
        format.html { redirect_to @ride_request.shuttle, notice: 'Ride request was successfully updated.' }
        format.json { render :show, status: :ok, location: @ride_request }
        else
          format.html { redirect_to @ride_request, notice: 'Ride request was successfully updated.' }
        end
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

  def set_rider_info
    puts "************* setting session info ****************"
    if params[:name]
      session[:name] = params[:name]
    end
    puts "*************name set****************"
    if params[:phone]
      fixed_number = params[:phone]
      fixed_number = fixed_number.tr("-", "")
      prefix = ""
      unless fixed_number[0] == "+"
        prefix = "+"
      end
      unless fixed_number[0] == "1" || fixed_number[1] =="1"
        prefix = prefix + "1"
      end
      session[:phone] = prefix.to_s + fixed_number.to_s
    end
    puts "**********phone set **********"
    if params[:email]
      session[:email] = params[:email]
    end
    puts " ********** email set **********"
    if params['redirect-shuttle']
      @shuttle = Shuttle.find(params['redirect-shuttle'])
      puts "**********redirecting...****************"
      return redirect_to shuttle_path(@shuttle)
    else
      return redirect_to new_ride_request_path
    end
  end
  def clear_rider_info
    session[:name] = nil
    session[:phone] = nil
    session[:email] = nil
    session[:latitude] = nil
    session[:longitude] = nil
  end

  def set_rider_location
    refresh = false
    if params[:lat]
      unless session[:latitude] == params[:lat]
        session[:latitude] = params[:lat]
        refresh = true
        puts "set lat: #{session[:latitude]}"
      end
    end
    if params[:long]
      unless session[:longitude] == params[:long]
        session[:longitude] = params[:long]
        puts "set long: #{session[:longitude]}"
        refresh = true
      end
    end
    if refresh
      return redirect_to new_ride_request_path
    end
  end

  def manager
    @lat = Location.first.latitude
    @long = Location.first.longitude
    if params[:driver]
      @shuttle = Shuttle.where(name: params[:driver]).first
      @ride_requests = RideRequest.where.not(completed: true).where(shuttle_id: @shuttle.id)
    else
      @ride_requests = RideRequest.where.not(completed: true)
    end
    @ride_request = RideRequest.new
    @ordered_locations = Location.all
  end

  def assign_to_shuttle
    @shuttle = Shuttle.find(params[:shuttle_id])
    @ride_request.shuttle = @shuttle
    @ride_request.advance_status(@ride_request.status)
    respond_to do |format|
      if @ride_request.save
        message = "Your ride is on its way. You can track the shuttle here: http://shuttle.resortlodgingcompany.com/shuttles/" + @ride_request.shuttle_id.to_s
        sms = SmsManager.new(to_number: @ride_request.phone, message: message)
        sms.send_message
        format.html { redirect_to ride_request_manager_path, notice: 'Ride request was successfully assigned.' }
      else

      end
    end
  end

  def reset_status
    @ride_request.status = "In Queue"
    @ride_request.shuttle = nil?
    @ride_request.save

    redirect_to ride_request_manager_path

  end

  def advance_status
    @ride_request.advance_status(@ride_request.status)
    redirect_to ride_request_manager_path
  end

  def mark_clear
    @ride_request.advance_status("Rolling")
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
      params.require(:ride_request).permit(:pickup_address, :dropoff_address, :riders, :requester_name, :shuttle_id, :completed, :phone, :note)
    end
end
