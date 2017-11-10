class ExperienceOccurancesController < ApplicationController
  before_action :set_experience_occurance, only: [:show, :edit, :update, :destroy]

  # GET /experience_occurances
  # GET /experience_occurances.json
  def index
    @experience_occurances = ExperienceOccurance.all
  end

  # GET /experience_occurances/1
  # GET /experience_occurances/1.json
  def show
  end

  # GET /experience_occurances/new
  def new
    @experience_occurance = ExperienceOccurance.new
  end

  # GET /experience_occurances/1/edit
  def edit
  end

  # POST /experience_occurances
  # POST /experience_occurances.json
  def create
    @experience_occurance = ExperienceOccurance.new(experience_occurance_params)

    respond_to do |format|
      if @experience_occurance.save
        format.html { redirect_to @experience_occurance, notice: 'Experience occurance was successfully created.' }
        format.json { render :show, status: :created, location: @experience_occurance }
      else
        format.html { render :new }
        format.json { render json: @experience_occurance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /experience_occurances/1
  # PATCH/PUT /experience_occurances/1.json
  def update
    respond_to do |format|
      if @experience_occurance.update(experience_occurance_params)
        format.html { redirect_to @experience_occurance, notice: 'Experience occurance was successfully updated.' }
        format.json { render :show, status: :ok, location: @experience_occurance }
      else
        format.html { render :edit }
        format.json { render json: @experience_occurance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /experience_occurances/1
  # DELETE /experience_occurances/1.json
  def destroy
    @experience_occurance.destroy
    respond_to do |format|
      format.html { redirect_to experience_occurances_url, notice: 'Experience occurance was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_experience_occurance
      if params[:experience_occurance_id]
        @experience_occurance = ExperienceOccurance.find(params[:experience_occurance_id])
      else
        @experience_occurance = ExperienceOccurance.find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def experience_occurance_params
      params.require(:experience_occurance).permit(:experience_id, :date, :capacity)
    end
end
