class PagesController < ApplicationController
  layout 'locations_theme'
  def index
    @header_experiences = ExperienceOccurance.where("date > ?", DateTime.now).order("date ASC").map{|eo| eo.experience}.uniq
  end
end
