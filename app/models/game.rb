class Game < ActiveRecord::Base
  belongs_to :event
  belongs_to :player1, :class_name => "Player", :foreign_key => "player1_id"
  belongs_to :player2, :class_name => "Player", :foreign_key => "player2_id"
  
  validates :player1, :presence => true
  validates :player2, :presence => true
  
  
  def otherPlayer(player)
    self.player1 == player ? self.player2 : self.player1
  end
  
  def playerResult(player)
    self.player1 == player ? result : -result
  end

  def playerResultAsString(player)
    r = playerResult(player)
    Game.resultAsString(r)
  end
  
  def resultAsString
    Game.resultAsString(self.result)
  end

  def self.resultAsString(result)
    return "win" if result == 1
    return "loss" if result == -1
    return "draw"
  end
  
  
  def calculate_rating
    difference = Float(self.player2.rating - self.player1.rating)
    expected = 1/(1 + 10 ** (difference / 400))
    actual = (Float(self.result) + 1) / 2
    rating = 15 * (actual - expected)
    Integer(rating.round)
  end
  
  def student1
  end
  
  def student2
  end
  
end
