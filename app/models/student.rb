class Student < ActiveRecord::Base
  belongs_to :family
  belongs_to :club
  has_and_belongs_to_many :groups
  has_and_belongs_to_many :terms
  has_many :players
  has_many :events, :through => :players

  #validates :family, :presence => true



  def self.find_all(term)
    term.students.order('firstname,lastname')
  end


  def self.all_active(term)
    term.students.where('active').order('firstname,lastname')
  end


  def self.all_inactive(term)
    term.students.where('NOT(active)').order('firstname,lastname')
  end

  def players_in_term(term)
    players.select {|p| p.event.term == term }
  end
  
  def self.find_by_ids(ids)
    conditions = ids.map { |id| "id=#{id}" }.join(" OR ")
    Student.all(:conditions => [conditions])
  end


  def current_player
    Player.first(:conditions => ['student_id = ?', self.id], :order => 'date DESC')
  end


  def games
    self.players.map { |p| p.games }.flatten
  end


  def set_rating_by_grade
    if self.grade.nil?
      throw "Student doesn't have a grade"
    end
    self.rating = self.grade == 0 ? 100 : self.grade * 100
  end


  def fullname
    self.firstname + " " + self.lastname
  end


  def current_rating
    self.rating
  end


  def adjust_rating(points)
    if self.rating.nil?
      throw "Student doesn't have rating"
    end
    self.rating += points
    self.save
  end


  def current_rating_as_string
    rating.nil? ? "No rating" : rating
  end


  def set_rating(rating)
    self.players << Player.create(:date => Time.now, :rating => rating)
    self.save
  end


  def set_rating_with_date(rating, date)
    self.players << Player.create(:date => date, :rating => rating)
    self.save
  end


  def readable_grade
    grade == 0 ? "K" : grade
  end


  def delta_rating_term(term)
    self.current_rating - self.first_player(term).rating
  end


  def first_player(term)
    players.select {|p| p.event.term == term }.first
  end


  def delta_rating_latest
    player = Event.latest.findPlayer(self)
    player.nil? ? "" : player.delta
  end


  def latest_game(opponent)
    opponent_player = opponent.current_player
    self_player = self.current_player
    Game.first(:conditions => ["(player1_id = ? and player2_id = ?) or (player1_id = ? and player2_id = ?)",
        self_player.id, opponent_player.id, opponent_player.id, self_player.id], :order => ['id DESC'])
  end


  def self.pairings(students)
    r = Random.new(Time.now.to_i)
    sorted = students.sort { |a,b| b.rating <=> a.rating }
    pairings = []

    if sorted.count.odd?
      index = r.rand(sorted.count)
      pairings << [sorted[index], sorted[index]]
      sorted.delete_at(index)
    end

    while sorted.count > 0
      student = sorted[0]
      attempts = 0
      while attempts < 5
        index = r.rand([10, sorted.count - 1].min) + 1
        opponent = sorted[index]
        last = student.latest_game(opponent)
        if !last
          break
        end
        attempts += 1
      end

      pairings << [student, opponent]
      sorted.delete_at(index)
      sorted.delete_at(0)
    end

    pairings
  end


  def self.pairings_slow(students)
    weights = Student.weights(students)
    pairings = []
    while weights.count > 1
      student = weights.keys[@r.rand(weights.keys.count)]
      sorted = weights[student].sort { |a, b| a[:weight][:weight] <=> b[:weight][:weight] }
      sorted_count = sorted.count
      found = false
      while !found
        index = [sorted_count, @r.rand(5)].min
        pair = sorted[index][:student]
        found = weights.has_key?(pair)
        if !found
          sorted.delete_at(index)
          sorted_count -= 1
        end
      end
      pairings << [student, pair, sorted[index][:weight]]
      weights.delete(student)
      weights.delete(pair)
    end
    if weights.count > 0
      last = weights.keys[0]
      pairings << [last, last, nil]
    end
    pairings
  end


  def self.weights(students)
    if !students
      students = Student.all_active
    end

    weights = {}
    students.each do |student|
      weight = []
      students.each do |other|
        if other != student
          weight << {:student => other, :weight => calculate_weight(student, other)}
        end
      end
      weights[student] = weight
    end
    weights
  end


  def self.calculate_weight(student1, student2)
    last_game = nil
    Game.first(:conditions => [], :order => '')
    student1.games.each do |game|
      if game.player1.student == student2 || game.player2.student == student2
        if last_game.nil? || game.event.date > last_game.event.date
          last_game = game
        end
      end
    end
    days = last_game.nil? ? 1 : [Time.now - last_game.event.date, 60].min
    rating = (student1.rating - student2.rating).abs
    {:weight => Float(rating) / days, :days => days, :rating => rating}
  end

end
