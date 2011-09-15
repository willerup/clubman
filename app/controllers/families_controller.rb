class FamiliesController < ApplicationController

  before_filter :require_coach
  

  def new_parent
    @family = Family.find(params[:id])
    @user = User.new(:family => @family)

    render :action => 'new', :controller => 'users'
  end


  def index
    @families = current_term.families

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @families }
    end
  end

end
