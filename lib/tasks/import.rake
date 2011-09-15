#Name,Grade,Rating,Name,Grade,Assessment,StartRating,Parent(s),Family,Email,Phone

#Aiden Teegarden	1	203	Aiden Teegarden	1	1		Kirsten & Dean	Teegarden	kirstentee@yahoo.com	338-5227
#Alastair Gough	2	171	Alastair Gough	2	3	148	Paige & Marco	Gough	paige.somoza@boiseschools.org	608-0207 440-8135

require 'csv'

task :import => :environment do

  first = true
  input = []
  headers = nil

  #----------------------- read in file
  file = CSV.open("lib/tasks/washington.csv")
  file.each do |row|
    if first
      headers = row
      first = false
    else
      entry = {}
      headers.size.times do |i|
        entry[headers[i]] = row[i] if row[i]
      end
      input << entry
    end
  end    

  #------------------------- set up events
  startEvent = Event.create(:name => "Start 2010", :date => "2010-09-01", :closed => true)
  green = Group.create(:name => 'Green', :style => 'Green')
  blue = Group.create(:name => 'Blue', :style => 'Blue')
  orange = Group.create(:name => 'Orange', :style => 'Orange')


  #----------------------- create students 
  input.each do |item|
    names = item['name'].split(" ")
    firstname = names[0]
    lastname = names[1]
    grade = item['grade']
    grade = 0 if grade == "K"
    
    student = Student.create(:firstname => firstname, :lastname => lastname, :grade => grade, :active => true)
    student.family = Family.find_by_name(lastname)
    if student.family == nil
      student.family = Family.create(:name => lastname, :email => item['email'], :phone => item['phone']) 
    end
    
    # Ratings
    if item['lastyear']
      player = Player.create(:rating => item['lastyear'], :event => startEvent, :date => startEvent.date)
      student.players << player
    end
    
    item.each do |date,rating|
      if date[0] == '2'
        event = Event.find_by_date(date)
        event = Event.create(:name => "Club Meeting #{date}", :date => date, :closed => true) if event == nil
        player = Player.create(:rating => rating, :event => event, :date => date)
        student.players << player
      end
    end

    student.save
  end

  #------------------------- weed out redundant entries
  Student.all.each do |student|
    previous = nil
    Player.all(:conditions => ["student_id = ?", student.id], :order => "date DESC").each do |current|
      if previous != nil 
        if previous.rating == current.rating
          previous.destroy
        else
          previous.delta = previous.rating - current.rating
          previous.rating = current.rating
          previous.save
        end
      end
      previous = current
    end
  end

  Student.all.each do |student|
    latest = Player.first(:conditions => ["student_id = ?", student.id], :order => "date DESC")
    student.rating = latest.adjustedRating
    student.groups << green if student.rating >= 350
    student.groups << blue if student.rating >= 200 && student.rating < 350
    student.groups << orange if student.rating < 200    
    student.save
  end

  #-------------------------- create new event to play around with
  #e = Event.create(:name => 'Club Meeting 2011-02-14', :date => '2011-02-14')
 
  #----------------------- Summarize import
  Student.find_all.each do |s|
    puts "#{s.firstname} #{s.rating} (#{s.players.size})"
  end
  puts "#{Student.find_all.size} students added"
end

