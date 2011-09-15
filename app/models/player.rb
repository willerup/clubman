class Player < ActiveRecord::Base
  belongs_to :student
  has_many :games
  belongs_to :event


  def adjustedRating
    self.rating + (self.delta.nil? ? 0 : self.delta)
  end

  def manual?
    event == nil
  end
  
  def setDelta!(points)
    self.student.adjust_rating(-self.delta) if !self.delta.nil?
    self.student.adjust_rating(points)
    self.delta = points
    self.save
  end
  
  def addToDelta!(points)
    self.student.adjust_rating(points)
    self.delta += points
    self.save
  end

  def date_string
    the_date = date ? date : event.date
    the_date.strftime("%Y-%m-%d")
  end
  
  def games
    Game.all(:conditions => ["player1_id = ? OR player2_id = ?", self.id, self.id])
  end
end
