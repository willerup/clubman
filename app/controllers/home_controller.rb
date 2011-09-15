class HomeController < ApplicationController

  def index
    if !current_user
      render :front
      
    elsif current_user.admin
      render :admin

    elsif current_user.coach
      render :coach
      
    else
      render :controller => :parent 
    
    end
  end


  def login
    if params[:id]
      UserSession.create(:login => params[:id], :password => params[:id])
      redirect_to :action => :index
    end
  end

end
