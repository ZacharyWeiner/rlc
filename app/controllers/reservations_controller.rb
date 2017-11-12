class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]

  # GET /reservations
  # GET /reservations.json
  def index
    @reservations = Reservation.all
  end

  # GET /reservations/1
  # GET /reservations/1.json
  def show
  end

  # GET /reservations/new
  def new
    @reservation = Reservation.new
    if params[:experience_id]
      @experience = Experience.find(params[:experience_id])
    elsif params[:experience_occurance_id]
      @experience_occurance = ExperienceOccurance.find(params[:experience_occurance_id])
      @experience = @experience_occurance.experience
    end

  end

  # GET /reservations/1/edit
  def edit
    @experience = @reservation.experience
    @experience_occurance = @reservation.experience_occurance
  end

  # POST /reservations
  # POST /reservations.json
  def create
    if reservation_params[:experience_id]
      @experience = Experience.find(reservation_params[:experience_id])
    elsif reservation_params[:experience_occurance_id]
      @experience_occurance = ExperienceOccurance.find(reservation_params[:experience_occurance_id])
      @experience = @experience_occurance.experience
    end
    @reservation = Reservation.new(reservation_params)
    if @reservation.experience.nil?
      @reservation.experience = @experience
    end
    respond_to do |format|
      if @reservation.save
        format.html { redirect_to experience_occurance_reservation_path(@experience_occurance, @reservation), notice: 'Reservation was successfully created.' }
        format.json { render :show, status: :created, location: @reservation }
      else
        format.html { render :new }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reservations/1
  # PATCH/PUT /reservations/1.json
  def update
    respond_to do |format|
      if @reservation.update(reservation_params)
        format.html { redirect_to @reservation, notice: 'Reservation was successfully updated.' }
        format.json { render :show, status: :ok, location: @reservation }
      else
        format.html { render :edit }
        format.json { render json: @reservation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reservations/1
  # DELETE /reservations/1.json
  def destroy
    @reservation.destroy
    respond_to do |format|
      format.html { redirect_to reservations_url, notice: 'Reservation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def deposit
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reservation
      @reservation = Reservation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reservation_params
      params.require(:reservation).permit(:name, :email, :phone, :experience_id, :count, :experience_occurance_id)
    end
end
