class PagesController < ApplicationController
  layout 'locations_2'
  def index
    @header_experiences = ExperienceOccurance.where("date > ?", DateTime.now).order("date ASC").map{|eo| eo.experience}.uniq
  end

  def right_column_list
  end
end
