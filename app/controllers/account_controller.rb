class AccountController < ApplicationController
  
  
  before_filter :require_admin
  
  def index
    @accounts = current_term.club.accounts.where(:family_id => nil)
  end
  
  def families
    @accounts = current_term.club.accounts.where("family_id")
  end

end
