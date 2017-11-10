class ExperienceIdeasController < ApplicationController
  before_action :set_experience_idea, only: [:show, :edit, :update, :destroy]

  # GET /experience_ideas
  # GET /experience_ideas.json
  def index
    @experience_ideas = ExperienceIdea.all
  end

  # GET /experience_ideas/1
  # GET /experience_ideas/1.json
  def show
  end

  # GET /experience_ideas/new
  def new
    @experience_idea = ExperienceIdea.new
  end

  # GET /experience_ideas/1/edit
  def edit
  end

  # POST /experience_ideas
  # POST /experience_ideas.json
  def create
    @experience_idea = ExperienceIdea.new(experience_idea_params)

    respond_to do |format|
      if @experience_idea.save
        format.html { redirect_to @experience_idea, notice: 'Experience idea was successfully created.' }
        format.json { render :show, status: :created, location: @experience_idea }
      else
        format.html { render :new }
        format.json { render json: @experience_idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /experience_ideas/1
  # PATCH/PUT /experience_ideas/1.json
  def update
    respond_to do |format|
      if @experience_idea.update(experience_idea_params)
        format.html { redirect_to @experience_idea, notice: 'Experience idea was successfully updated.' }
        format.json { render :show, status: :ok, location: @experience_idea }
      else
        format.html { render :edit }
        format.json { render json: @experience_idea.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /experience_ideas/1
  # DELETE /experience_ideas/1.json
  def destroy
    @experience_idea.destroy
    respond_to do |format|
      format.html { redirect_to experience_ideas_url, notice: 'Experience idea was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_experience_idea
      @experience_idea = ExperienceIdea.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def experience_idea_params
      params.require(:experience_idea).permit(:title, :duration, :category_id, :capacity, :description)
    end
end
