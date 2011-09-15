class RatingsController < ApplicationController

  before_filter :require_coach
  
  def index
    @students = Student.all_active(current_term)
    @groups = Group.all_by_term(current_term)
  end
  
  def history
    @students = Student.all_active(current_term)
    @events = Event.all(:order => 'date DESC')
  end
end
