class AccountEventsController < ApplicationController

  before_filter :require_coach


  def purchase
    @student = Student.find(params[:id])
    @product = Product.find(params[:product])

    Account.student_buy(@student, @product, Time.now)
    redirect_to student_path(@student)
  end


  def payment
    @student = Student.find(params[:id])
    amount = params[:amount]
    
    Account.family_pay(@student.family, amount, Time.now)
    redirect_to student_path(@student)
  end
  
end
