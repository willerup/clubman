class Event < ActiveRecord::Base
  belongs_to :club
  belongs_to :term
  has_many :games
  has_many :players
  has_many :students, :through => :players
  
  
  def is_start_term
    self.term.start_term == self
  end
  
  
  def self.all_by_term(term)
    where('term_id = ?', term).order('date DESC')
  end
  
  def getOrCreatePlayerFromStudent(student)
    player = findPlayer(student)
    if player.nil?
      player = Player.create(:student => student, :rating => student.current_rating)
    end
    players << player
    return player
  end
  
  def gamesByPlayer(player)
    playerGames = []
    games.each do |game|
      if game.player1 == player || game.player2 == player
        playerGames << game
      end
    end
    return playerGames
  end

  def date_string
    date.strftime("%Y-%m-%d")
  end
  
  def findPlayer(student)
    self.players.find_by_student_id(student.id)
  end
  
  def self.latest
    Event.find(:first, :order => 'date DESC')
  end
  
  def closeAndAdjustRatings!
    updatePlayerDeltas
    self.closed = true
    self.save
  end
  
  def updatePlayerDeltas
    self.players.each do |player|
      player.setDelta!(0)
    end
    
    self.games.each do |game|
      delta = game.calculate_rating
      game.player1.addToDelta!(+delta)
      game.player2.addToDelta!(-delta)
    end    
  end
  
  
  
  def maxGames
    max = 0
    self.players.each do |player|
      games = gamesByPlayer(player)
      max = games.size if games.size > max
    end
    return max
  end
  
end
