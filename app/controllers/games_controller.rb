class GamesController < ApplicationController

  before_filter :require_coach
  
  def index
    @games = Game.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @games }
    end
  end

  def show
    @game = Game.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @game }
    end
  end

  def new
    event = Event.find(params['id'])
    student = Student.find(params['student'])
    @player = Player.first(:conditions => ['event_id = ? AND student_id = ?', event.id, student.id])
    if @player == nil
      @player = Player.create(:student => student, :event => event, :rating => student.current_rating)
    end
    @game = Game.new(:player1 => @player, :event => event, :result => 1)
    @players = Player.all(:conditions => ['event_id = ?', event.id])

    respond_to do |format|
      format.html { render :action => "edit" }
      format.xml  { render :xml => @game }
    end
  end
  
  def edit
    @game = Game.find(params[:id])
  end

  def create
    @game = Game.new(params[:game])

    respond_to do |format|
      if @game.save
        format.html { redirect_to(:controller => 'events', :action => 'edit', :id => @game.event.id, :notice => 'Game was successfully created.') }
        format.xml  { render :xml => @game, :status => :created, :location => @game }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @game.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @game = Game.find(params[:id])

    respond_to do |format|
      if @game.update_attributes(params[:game])
        format.html { redirect_to(@game, :notice => 'Game was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @game.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @game = Game.find(params[:id])
    @game.destroy
    render :text => "true"
  end
end
