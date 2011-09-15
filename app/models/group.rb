class Group < ActiveRecord::Base
  has_and_belongs_to_many :students
  has_many :families, :through => :students 
  belongs_to :term
  
  has_many :users

  def self.styles
    ['Grey', 'Green', 'Blue', 'Orange', 'Red', 'Yellow']
  end
  
  def self.all_by_term(term)
    where("term_id = ?", term)
  end
end
