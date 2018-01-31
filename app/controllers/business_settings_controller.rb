class BusinessSettingsController < ApplicationController
  before_action :set_business_setting, only: [:show, :edit, :update, :destroy, :activate_ride_requests, :deactivate_ride_requests]
  layout 'locations_2'
  # GET /business_settings
  # GET /business_settings.json
  def index
    @business_settings = BusinessSetting.all
  end

  # GET /business_settings/1
  # GET /business_settings/1.json
  def show
  end

  # GET /business_settings/new
  def new
    @business_setting = BusinessSetting.new
  end

  # GET /business_settings/1/edit
  def edit
  end

  # POST /business_settings
  # POST /business_settings.json
  def create
    @business_setting = BusinessSetting.new(business_setting_params)

    respond_to do |format|
      if @business_setting.save
        format.html { redirect_to @business_setting, notice: 'Business setting was successfully created.' }
        format.json { render :show, status: :created, location: @business_setting }
      else
        format.html { render :new }
        format.json { render json: @business_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /business_settings/1
  # PATCH/PUT /business_settings/1.json
  def update
    respond_to do |format|
      if @business_setting.update(business_setting_params)
        format.html { redirect_to @business_setting, notice: 'Business setting was successfully updated.' }
        format.json { render :show, status: :ok, location: @business_setting }
      else
        format.html { render :edit }
        format.json { render json: @business_setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /business_settings/1
  # DELETE /business_settings/1.json
  def destroy
    @business_setting.destroy
    respond_to do |format|
      format.html { redirect_to business_settings_url, notice: 'Business setting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def activate_ride_requests
    @business_setting.ride_request_active = true
    @business_setting.save
    OnOffTracker.create!(status: "active")
    redirect_to ride_request_manager_path
  end

  def deactivate_ride_requests
    @business_setting.ride_request_active = false
    @business_setting.save
    OnOffTracker.create!(status: "inactive")
    redirect_to ride_request_manager_path
  end

  def set_play_sound
    bs = BusinessSetting.first
    if bs.play_sound == true
      bs.play_sound = false;
      bs.save
    else
      bs.play_sound = true
      bs.save
    end
    redirect_to ride_request_manager_path
  end

  def on_off_tracker
    @trackers = OnOffTracker.all.reverse
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_business_setting
      if params[:business_setting_id]
         @business_setting = BusinessSetting.find(params[:business_setting_id])
       else
        @business_setting = BusinessSetting.find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def business_setting_params
      params.require(:business_setting).permit(:ride_request_active, :title)
    end
end
