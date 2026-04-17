class ExpensesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_house
  before_action :set_expense, only: [:destroy]

  def new
    @expense = @house.expenses.new(expense_date: Date.today)
  end

  def create
    @expense = @house.expenses.new(expense_params)
    if @expense.save
      redirect_to house_path(@house), notice: "Expense logged successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @expense.destroy
    redirect_to house_path(@house), notice: "Expense deleted successfully."
  end

  private

  def set_house
    @house = current_user.houses.find(params[:house_id])
  end

  def set_expense
    @expense = @house.expenses.find(params[:id])
  end

  def expense_params
    params.require(:expense).permit(:amount, :expense_type, :description, :expense_date)
  end
end
