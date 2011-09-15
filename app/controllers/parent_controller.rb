class ParentController < ApplicationController
  
  before_filter :require_parent
  
  def index
    @students = current_user.students
  end

end
