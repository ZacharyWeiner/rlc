class KillSwitchesController < ApplicationController
  before_action :set_kill_switch, only: [:show, :edit, :update, :destroy]

  # GET /kill_switches
  # GET /kill_switches.json
  def index
    @kill_switches = KillSwitch.all
  end

  # GET /kill_switches/1
  # GET /kill_switches/1.json
  def show
  end

  # GET /kill_switches/new
  def new
    @kill_switch = KillSwitch.new
  end

  # GET /kill_switches/1/edit
  def edit
  end

  # POST /kill_switches
  # POST /kill_switches.json
  def create
    @kill_switch = KillSwitch.new(kill_switch_params)

    respond_to do |format|
      if @kill_switch.save
        format.html { redirect_to @kill_switch, notice: 'Kill switch was successfully created.' }
        format.json { render :show, status: :created, location: @kill_switch }
      else
        format.html { render :new }
        format.json { render json: @kill_switch.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /kill_switches/1
  # PATCH/PUT /kill_switches/1.json
  def update
    respond_to do |format|
      if @kill_switch.update(kill_switch_params)
        format.html { redirect_to @kill_switch, notice: 'Kill switch was successfully updated.' }
        format.json { render :show, status: :ok, location: @kill_switch }
      else
        format.html { render :edit }
        format.json { render json: @kill_switch.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /kill_switches/1
  # DELETE /kill_switches/1.json
  def destroy
    @kill_switch.destroy
    respond_to do |format|
      format.html { redirect_to kill_switches_url, notice: 'Kill switch was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_kill_switch
      @kill_switch = KillSwitch.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def kill_switch_params
      params.require(:kill_switch).permit(:is_active)
    end
end
