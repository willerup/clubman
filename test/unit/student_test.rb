require 'test_helper'

class StudentTest < ActiveSupport::TestCase

  test "Creation and basic propterties" do
    s = Student.create :firstname => 'First', :lastname => 'Last', :grade => 3
    assert_equal "First", s.firstname
    assert_equal "Last", s.lastname
   end

  test "rating" do
    s = Student.create :firstname => 'First', :lastname => 'Last', :grade => 3
    assert_nil s.current_rating
    
    s.set_rating(100)
    assert_equal 100, s.current_rating.rating
    
    s.set_rating(200)
    assert_equal 200, s.current_rating.rating
 
    assert_equal 2, s.players.size
  end

end
