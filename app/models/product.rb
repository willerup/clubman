class Product < ActiveRecord::Base  

  belongs_to :club
  
  def self.all_by_club(club)
    Product.where("club_id = ?", club).order(:name)
  end
  
end
