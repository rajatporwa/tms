class TenantsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_house
  before_action :set_house_room
  before_action :set_tenant, only: %i[show update destroy edit vacate]

  def index
    @tenants = @house_room.tenants.order(:first_name)
  end

  def new
    @tenant = Tenant.new
    @tenant.house_room = @house_room
    @tenant.tenant_partners.build
  end

  def create
    @tenant = @house_room.tenants.build(tenant_params)
    if @tenant.save
      redirect_to house_house_room_path(@house, @house_room), notice: "Tenant added successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    if @tenant.update(tenant_params)
      redirect_to house_house_room_tenant_path(@house, @house_room, @tenant), notice: "Tenant updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def vacate
    # Check for pending dues
    billed = @tenant.monthly_bills.sum(:total_amount)
    paid   = @tenant.payments.sum(:amount)
    pending = billed - paid

    if pending > 0
      redirect_to house_path(@house), alert: "Cannot vacate! ₹#{pending.to_i} pending dues must be cleared first."
      return
    end

    if @tenant.update(status: 'vacated', rent_end_date: Date.today)
      redirect_to house_path(@house), notice: "#{@tenant.first_name} successfully vacated. Room is now free."
    else
      redirect_to house_path(@house), alert: "Failed to vacate tenant."
    end
  end

  def destroy
    @tenant.destroy
    redirect_to house_house_room_path(@house, @house_room), notice: "Tenant removed."
  end

  private

  def tenant_params
    params.require(:tenant).permit(
      :house_room_id, :first_name, :last_name, :dob, :gender, :father_name, :mother_name, :father_contact, :mother_contact, :mobile, :alternate_mobile, :before_rent_address, :permanent_address, :postal_code, :district, :state, :country, :occupation, :occupation_contact, :occupation_address, :document_type, :document_number, :vehicle_no, :no_of_partners, :rent_start_date, :rent_end_date, :status, :document_file, :profile_photo,
      vehicles_attributes: [:id, :vehicle_name, :vehicle_no, :vehicle_type, :_destroy],
      tenant_partners_attributes: [
        :id, :first_name, :last_name, :dob, :gender, :father_name, :mother_name, :father_contact, :mother_contact, :mobile, :alternate_mobile, :before_rent_address, :permanent_address, :postal_code, :district, :state, :country, :occupation, :occupation_contact, :occupation_address, :document_type, :document_number, :document_file, :profile_photo, :vehicle_no, :no_of_partners, :rent_start_date, :rent_end_date, :status, :_destroy
      ]
    )
  end

  def set_house
    @house = current_user.houses.find(params[:house_id])
  end

  def set_house_room
    @house_room = @house.house_rooms.find(params[:house_room_id])
  end

  def set_tenant
    @tenant = Tenant.find_by(id: params[:id])
  end
end
