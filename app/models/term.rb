class Term < ActiveRecord::Base
  belongs_to :club
  has_and_belongs_to_many :students
  has_many :events
  belongs_to :start_event, :class_name => 'Event'
  
  def current
    self.club.term == self
  end
 
  def families
    students.collect(&:family).sort_by(&:name).uniq
  end
 
end
