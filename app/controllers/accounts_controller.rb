class AccountsController < ApplicationController
  
  
  before_filter :require_admin
  
  def index
    @accounts = current_term.club.accounts.where(:family_id => nil)
    @income = current_term.club.accounts.where(:account_type => "income")
    @expense = current_term.club.accounts.where(:account_type => "expense")
    @cash = current_term.club.accounts.where(:account_type => "cash")
    @liability = current_term.club.accounts.where(:account_type => "liability")
  end
  
  def families
    @accounts = current_term.club.accounts.where("family_id")
  end
  
  def show
    @account = Account.find(params[:id])
  end

end
