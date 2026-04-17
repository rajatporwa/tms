class HousesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_house, only: %i[show edit update destroy]

  def index
    @houses = current_user.houses
  end

  def show
    # Occupancy
    @house_rooms = @house.house_rooms.includes(:tenants)
    @occupied_rooms = 0
    @total_rent_expected = 0
    @total_active_tenants = 0
    @pending_dues = 0

    @house_rooms.each do |room|
      active_tenant = room.tenants.find { |t| t.status == 'active' }
      if active_tenant
        @occupied_rooms += 1
        @total_rent_expected += room.rent.to_f
        @total_active_tenants += 1 + active_tenant.tenant_partners.count

        # Pending Dues calculation
        billed = active_tenant.monthly_bills.sum(:total_amount)
        paid = active_tenant.payments.sum(:amount)
        dues = billed - paid
        @pending_dues += dues if dues > 0
      end
    end

    # Expenses
    @recent_expenses = @house.expenses.order(expense_date: :desc, created_at: :desc).limit(5)
    @monthly_expenses_total = @house.expenses.where(expense_date: Date.today.beginning_of_month..Date.today.end_of_month).sum(:amount)
  end

  def new
    @house = current_user.houses.new
  end

  def create
    @house = current_user.houses.new(house_params)
    if @house.save
      redirect_to houses_path, notice: "House created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

	def edit
	end

  def update
    old_no_of_rooms = @house.no_of_rooms || 0
    if @house.update(house_params)
      if @house.no_of_rooms > old_no_of_rooms
        (old_no_of_rooms + 1..@house.no_of_rooms).each do |room_no|
          @house.house_rooms.find_or_create_by(room_number: room_no)
        end
      end
      redirect_to houses_path, notice: "House updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @house.destroy
    redirect_to houses_path, notice: "House Deleted"
  end

  private

  def set_house
    @house = current_user.houses.find(params[:id])
  end

  def house_params
    permitted = params.require(:house).permit(:house_name, :address, :owner_name, :owner_id, :no_of_rooms, house_images: [])
    permitted.delete(:house_images) if permitted[:house_images].blank? || permitted[:house_images].all?(&:blank?)
    permitted
  end
end
