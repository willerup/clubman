class StudentsController < ApplicationController

  before_filter :require_admin, :only => ['destroy', 'create', 'new']
  before_filter :require_coach
  
  
  def pairings
    ids = params[:id].split(',')
    @students = Student.find_by_ids(ids)
    @pairings = Student.pairings(@students)
  end


  def index
    @active_students = Student.all_active(current_term)
    @inactive_students = Student.all_inactive(current_term)
    @selected_groups = Group.all_by_term(current_term)
    @groups = Group.all_by_term(current_term)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @students }
    end
  end

  def print
    @students = Student.all_active(current_term)
    render :layout => "layouts/print"
  end

  def show
    @student = Student.find(params[:id])
    @families = current_term.families
    @groups = Group.all_by_term(current_term)
    @family = @student.family
    @players = @student.players_in_term(current_term)
    @term = current_term
    @products = Product.all_by_club(current_club)
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @student }
    end
  end


  def new
    @students = current_club.students - current_term.students
    @student = Student.new(:active => true, :club => current_club)
    @families = Family.all_by_club(current_club)
    @family = nil
    @groups = Group.all_by_term(current_term)

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @student }
    end
  end
  

  def edit
    @student = Student.find(params[:id])
    @families = Family.all
    @family = @student.family
    @groups = Group.all_by_term(current_term)
    
    if params[:add_to_term] && !@student.terms.include?(current_term)
      @student.terms << current_term
      @student.players << Player.create(:date => Time.now, :rating => @student.rating, :delta => 0, :event => current_term.start_event)
      @student.save
    end
  end


  def create
    @student = Student.new(params[:student])

    if !@student.family && params[:family][:id] != ""
      @student.family = Family.find(params[:family][:id])
    else
      if params[:family][:name] != ""
        @student.family = Family.create(params[:family])
        @student.family.club = current_club
      else
        @student.family = Family.find_by_name(@student.lastname)
        if !@student.family
          @student.family = Family.create(:name => @student.lastname, :club => current_club)
        end
      end
    end
    
    if !@student.family.account
      account = Account.create(:name => @student.family.name, :account_type => Account::CASH, :family => @student.family, :club => current_club)
      @student.family.account = account
      @student.family.save
    end
    
    if !@student.rating && @student.grade
      @student.set_rating_by_grade
    end
    
    respond_to do |format|
      if @student.save
        @student.players << 
          Player.create(:date => Time.now, :rating => @student.rating, :delta => 0, :event => current_term.start_event)
        @student.terms << current_term
        @student.save
        
        format.html { redirect_to(@student, :notice => 'Student was successfully created.') }
        format.xml  { render :xml => @student, :status => :created, :location => @student }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @student.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update
    @student = Student.find(params[:id])
    
    if !@student.family && params[:family][:id] != ""
      @student.family = Family.find(params[:family][:id])
    end
    if !@student.family 
      @student.family = Family.find_by_name(@student.lastname)
    end
    if !@student.family
      @student.family = Family.create(:name => @student.lastname)
    end

    respond_to do |format|
      if @student.update_attributes(params[:student])
        format.html { redirect_to(@student, :notice => 'Student was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @student.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @student = Student.find(params[:id])
    @student.destroy

    respond_to do |format|
      format.html { redirect_to(students_url) }
      format.xml  { head :ok }
    end
  end
end
