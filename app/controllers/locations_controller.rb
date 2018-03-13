class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  layout 'shuttle_layout'
  # GET /locations
  # GET /locations.json
  def index
    @locations = Location.all.order(:priority)
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
  end

  # GET /locations/new
  def new
    @location = Location.new
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = Location.new(location_params)
    respond_to do |format|
      if @location.save
        format.html { redirect_to @location, notice: 'Location was successfully created.' }
        format.json { render :show, status: :created, location: @location }
      else
        format.html { render :new }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to @location, notice: 'Location was successfully updated.' }
        format.json { render :show, status: :ok, location: @location }
      else
        format.html { render :edit }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location.destroy
    respond_to do |format|
      format.html { redirect_to locations_url, notice: 'Location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def set_show_after_2
    set_location
    if @location.show_after_2 == true
      @location.show_after_2 = false
    else
      @location.show_after_2 = true
    end
    @location.save
    redirect_to locations_path
  end

  def toggle_shuttle_stop
    set_location
    if @location.is_shuttle_stop
      @location.is_shuttle_stop = false
    else
      @location.is_shuttle_stop = true
    end
    @location.save
    redirect_to locations_path
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      if params[:location_id]
        @location = Location.find(params[:location_id])
      else
      @location = Location.find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def location_params
      params.require(:location).permit(:name, :address, :latitude, :longitude, :raw_address, :priority, :instruction, :image)
    end
end
