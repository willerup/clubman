class RatingsController < ApplicationController

  before_filter :require_coach
  
  def index
    @term = current_term
    @students = Student.all_active(@term)
    @groups = Group.all_by_term(@term)
  end
  
  def history
    @term = current_term
    @students = Student.all_active(@term)
    @events = Event.all(:order => 'date DESC')
  end
end
