class ExperiencesController < ApplicationController
  before_action :set_experience, only: [:show, :edit, :update, :destroy, :add_company, :remove_company]
  layout 'locations_2'
  # GET /experiences
  # GET /experiences.json
  def index
    @experiences = Experience.all
  end

  # GET /experiences/1
  # GET /experiences/1.json
  def show
    @reservation = Reservation.new
  end

  # GET /experiences/new
  def new
    @experience = Experience.new
  end

  # GET /experiences/1/edit
  def edit
  end

  # POST /experiences
  # POST /experiences.json
  def create
    @experience = Experience.new(experience_params)
    respond_to do |format|
      if @experience.save
        create_occurences
        format.html { redirect_to @experience, notice: 'Experience was successfully created.' }
        format.json { render :show, status: :created, location: @experience }
      else
        format.html { render :new }
        format.json { render json: @experience.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /experiences/1
  # PATCH/PUT /experiences/1.json
  def update
    respond_to do |format|
      if @experience.update(experience_params)
        format.html { redirect_to @experience, notice: 'Experience was successfully updated.' }
        format.json { render :show, status: :ok, location: @experience }
      else
        format.html { render :edit }
        format.json { render json: @experience.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /experiences/1
  # DELETE /experiences/1.json
  def destroy
    @experience.destroy
    respond_to do |format|
      format.html { redirect_to experiences_url, notice: 'Experience was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def add_company
    business = Business.find(params[:id])
    if @experience.businesses.include?(business)

    else
      @experience.businesses << business
    end
    redirect_to edit_experience_path(@experience)
  end

  def remove_company
    business = Business.find(params[:id])
    if @experience.businesses.include?(business)
      @experience.businesses.destroy(business)
    else

    end
    redirect_to edit_experience_path(@experience)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_experience
      if params[:experience_id]
        @experience = Experience.find(params[:experience_id])
      else
        @experience = Experience.find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def experience_params
      params.require(:experience).permit(:title, :duration, :capacity, :description, :cost, :start_date, :end_date, :recurrs_every, :header_image)
    end

    def create_occurences
      date = @experience.start_date
      occurrance = get_occurance(date)
      if occurrance.nil?
        occurrance = @experience.experience_occurances.create!(date: date, capacity: @experience.capacity)
      end
      while(date < @experience.end_date)
        date = next_date(date)
        occurrance = @experience.experience_occurances.create!(date: date, capacity: @experience.capacity)
      end
    end

    def get_occurance(date)
      return @experience.experience_occurances.where(date: date).first
    end

    def next_date(date)
      if @experience.recurrs_every == "Day"
        return date + 1.day
      elsif  @experience.recurrs_every == "Week"
        return date + 7.days
       elsif @experience.recurrs_every == "Other Week"
        return date + 14.days
       @experience.recurrs_every == "Month"
        return date + 28.days;
      end
    end
end
