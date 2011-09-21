class UsersController < ApplicationController

  before_filter :require_admin, :except => ['edit']
  before_filter :require_user, :only => ['edit', 'update']


  def index
    @users = current_club.users
    render :index
  end


  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @user }
    end
  end


  def edit
    if current_user.admin
      @user = User.find(params[:id])
    else
      @user = current_user
    end
  end


  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @user }
    end
  end


  def create
    @user = User.new(params[:user])
    @user.club = current_club
    
    respond_to do |format|
      if @user.save
        format.html { redirect_to(root_url, :notice => 'Registration successful.') }
        format.xml { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update
    if current_user.admin
      @user = User.find(params[:id])
    else
      @user = current_user
    end

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(root_url, :notice => 'User information updated.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml { head :ok }
    end
  end
end
