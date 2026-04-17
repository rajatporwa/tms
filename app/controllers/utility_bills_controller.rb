class UtilityBillsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_context
  before_action :set_utility_bill, only: %i[show edit update destroy]

  def index
    @utility_bills = @monthly_bill.utility_bills
  end

  def new
    @utility_bill = @monthly_bill.utility_bills.new
  end

  def create
    @utility_bill = @monthly_bill.utility_bills.new(utility_bill_params)
    if @utility_bill.save
      redirect_to house_house_room_tenant_monthly_bill_path(@house, @house_room, @tenant, @monthly_bill),
                  notice: "Utility bill added."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @utility_bill.update(utility_bill_params)
      redirect_to house_house_room_tenant_monthly_bill_path(@house, @house_room, @tenant, @monthly_bill),
                  notice: "Utility bill updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @utility_bill.destroy
    redirect_to house_house_room_tenant_monthly_bill_path(@house, @house_room, @tenant, @monthly_bill),
                notice: "Utility bill deleted."
  end

  private

  def set_context
    @house       = current_user.houses.find(params[:house_id])
    @house_room  = @house.house_rooms.find(params[:house_room_id])
    @tenant      = @house_room.tenants.find(params[:tenant_id])
    @monthly_bill = @tenant.monthly_bills.find(params[:monthly_bill_id])
  end

  def set_utility_bill
    @utility_bill = @monthly_bill.utility_bills.find(params[:id])
  end

  def utility_bill_params
    params.require(:utility_bill).permit(:utility_type, :start_unit, :end_unit, :unit_rate)
  end
end
