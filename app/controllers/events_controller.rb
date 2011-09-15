class EventsController < ApplicationController

  before_filter :require_coach
  
  def index
    @students = Student.all_active(current_term)
    @events = Event.all_by_term(current_term)
  end


  def show
    @event = Event.find(params[:id])
  end


  def edit
    @students = Student.all_active(current_term)
    @event = Event.find(params[:id])
    @game = Game.new(:event => @event, :result => 1)
  end


  def create_game
    @event = Event.find(params[:id])
    student1 = Student.find(params[:game][:student1])
    student2 = Student.find(params[:game][:student2])
    @player1 = @event.getOrCreatePlayerFromStudent(student1)
    @player2 = @event.getOrCreatePlayerFromStudent(student2)
    Game.create(:event => @event, :result => params[:game][:result],
                :player1 => @player1, :player2 => @player2)

    @students = Student.all_active
    @game = Game.new(:event => @event, :result => 1)

    render :action => "edit"
  end


  def close_event
    @event = Event.find(params[:id])
    @event.closeAndAdjustRatings!
    redirect_to(@event, :action => show)
  end
  

  def update_ratings
    @event = Event.find(params[:id])
    @event.updatePlayerDeltas

    redirect_to(@event, :action => show)
  end


  def new_game
    @students = Student.all_active(current_term)
    @event = Event.find(params[:id])
    @game = Game.new(:event => @event, :result => 1)

    render :partial => "game"
  end

  def add_player
    event = Event.find(params[:id])
    student = Student.find(params[:student])
    player = Player.create(
        :event => event,
        :student => student,
        :rating => student.current_rating,
        :date => event.date)

    render :text => player.rating
  end

  def new
    @students = Student.all_active(current_term)
    @event = Event.new(:date => Time.now, :closed => false)
  end


  def create
    @event = Event.new(params[:event])
    @event.closed = false
    @event.term = current_term

    respond_to do |format|
      if @event.save
        format.html { redirect_to(@event, :action => 'edit', :notice => 'Event was successfully created.') }
        format.xml { render :xml => @event, :status => :created, :location => @event }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end


  def update
    @event = Event.find(params[:id])

    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to(@event, :notice => 'Event was successfully updated.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @event.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to(events_url) }
      format.xml { head :ok }
    end
  end
end
