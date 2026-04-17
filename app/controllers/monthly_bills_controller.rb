class MonthlyBillsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_house
  before_action :set_house_room
  before_action :set_tenant
  before_action :set_monthly_bill, only: %i[show edit update destroy]

  def index
    @monthly_bills = @tenant.monthly_bills.order(year: :desc, month: :desc)
  end

  def new
    @monthly_bill = @tenant.monthly_bills.new(
      house: @house,
      house_room: @house_room,
      rent_amount: @house_room.rent,
      month: Date.today.month,
      year: Date.today.year
    )
    @monthly_bill.utility_bills.build(utility_type: 'Electricity')
  end

  def create
    @monthly_bill = @tenant.monthly_bills.new(monthly_bill_params)
    @monthly_bill.house = @house
    @monthly_bill.house_room = @house_room
    if @monthly_bill.save
      redirect_to house_house_room_tenant_monthly_bill_path(@house, @house_room, @tenant, @monthly_bill),
                  notice: "Monthly bill created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
    @monthly_bill.utility_bills.build
  end

  def update
    if @monthly_bill.update(monthly_bill_params)
      redirect_to house_house_room_tenant_monthly_bill_path(@house, @house_room, @tenant, @monthly_bill),
                  notice: "Monthly bill updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @monthly_bill.destroy
    redirect_to house_house_room_tenant_monthly_bills_path(@house, @house_room, @tenant),
                notice: "Bill deleted."
  end

  private

  def set_house
    @house = current_user.houses.find(params[:house_id])
  end

  def set_house_room
    @house_room = @house.house_rooms.find(params[:house_room_id])
  end

  def set_tenant
    @tenant = @house_room.tenants.find(params[:tenant_id])
  end

  def set_monthly_bill
    @monthly_bill = @tenant.monthly_bills.find(params[:id])
  end

  def monthly_bill_params
    params.require(:monthly_bill).permit(
      :month, :year, :rent_amount, :maintenance_amount, :due_date, :paid_amount, :status,
      utility_bills_attributes: [:id, :utility_type, :start_unit, :end_unit, :unit_rate, :_destroy]
    )
  end
end
