class TermsController < ApplicationController
  
  before_filter :require_coach
  
  
  
  # GET /terms
  # GET /terms.xml
  def index
    @terms = Term.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @terms }
    end
  end

  # GET /terms/1
  # GET /terms/1.xml
  def show
    @term = Term.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @term }
    end
  end

  # GET /terms/new
  # GET /terms/new.xml
  def new
    @term = Term.new(:club => current_club)
    @date = Date.today

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @term }
    end
  end

  # GET /terms/1/edit
  def edit
    @term = Term.find(params[:id])
    @date = @term.start_event.date
  end

  # POST /terms
  # POST /terms.xml
  def create
    @term = Term.new(params[:term])
    date = params[:start_date]
    
    respond_to do |format|
      if @term.save
        event = Event.create(:date => date, :name => "Start " + @term.name, :term => @term)
        @term.start_event = event
        @term.save 
        
        format.html { redirect_to(terms_url, :notice => 'Term was successfully created.') }
        format.xml  { render :xml => @term, :status => :created, :location => @term }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @term.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /terms/1
  # PUT /terms/1.xml
  def update
    @term = Term.find(params[:id])

    respond_to do |format|
      if @term.update_attributes(params[:term])
        format.html { redirect_to(terms_url, :notice => 'Term was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @term.errors, :status => :unprocessable_entity }
      end
    end
  end


  def set_current
    club = current_club
    term = Term.find(params[:id])

    if term
      club.term = term
      club.save
      render :text => 'true'
    else
      render :text => 'false'
    end
  end
  
  # DELETE /terms/1
  # DELETE /terms/1.xml
  def destroy
    @term = Term.find(params[:id])
    @term.destroy

    respond_to do |format|
      format.html { redirect_to(terms_url) }
      format.xml  { head :ok }
    end
  end
end
