class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user
  helper_method :current_club

  helper_method :is_admin?
  helper_method :is_coach?
  helper_method :is_god?


  private

  def current_term
    current_club.term
  end

  def current_club
    return current_user.club if current_user && current_user.club
    false
  end

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end
  
  def is_coach?
    current_user && (current_user.coach || is_admin?)
  end
  
  def is_admin?
    current_user && (current_user.admin || is_god?)
  end

  def is_god?
    current_user && (current_user.god)
  end
  
  def require_user
    unless current_user
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to new_user_session_url
      return false
    end
  end

  def require_parent
    unless current_user && current_user.family
      store_location
      flash[:notice] = "You must be logged in as a parent to access this page"
      redirect_to new_user_session_url
      return false
    end
  end

  def require_admin
    unless is_admin?
      store_location
      flash[:notice] = "You must be logged in with admin priviledges to access this page"
      redirect_to new_user_session_url
      return false
    end
  end
  
  def require_coach
    unless is_coach?
      store_location
      flash[:notice] = "You must be logged in with coach privileges to access this page"
      redirect_to new_user_session_url
      return false
    end
  end
  
  def require_god
      unless is_god?
        store_location
        flash[:notice] = "You must be logged in with coach privileges to access this page"
        redirect_to new_user_session_url
        return false
      end
    end
  
  def require_no_user
    if current_user
      store_location
      flash[:notice] = "You cannot be logged in when accessing this page"
      redirect_to root_url
      return false
    end
  end

  def store_location
    session[:return_to] = request.request_uri
  end
  
  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
end
