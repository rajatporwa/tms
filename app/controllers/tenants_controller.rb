class TenantsController < ApplicationController
  before_action :set_house, only: %i[new create show update destroy edit]
  before_action :set_house_room, only: %i[new create show update destroy edit]
  before_action :set_tenant, only: %i[new create show update destroy edit]
  
  def index
    @tenants = Tenant.all
  end

  def new
    @tenant = Tenant.new
    @tenant.house_room = @house_room
    @tenant.tenant_partners.build
  end

  def create
    @tenant = @house_room.tenants.build(tenant_params)
    if @tenant.save
      @tenant.house_room.update!(status: :occupied)
      redirect_to house_path(@house), notice: "tenant with partner created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @house_room.tenants
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def tenant_params
    params.require(:tenant).permit( :house_room_id, :first_name, :last_name, :dob, :gender, :father_name, :mother_name, :father_contact, :mother_contact, :mobile, :alternate_mobile, :before_rent_address, :permanent_address, :postal_code, :district, :state, :country, :occupation, :occupation_contact, :occupation_address, :document_type, :document_number, :vehicle_no, :no_of_partners, :rent_start_date, :rent_end_date, :status,:document_file, :profile_photo,
      tenant_partners_attributes: [:first_name, :last_name, :dob, :gender, :father_name, :mother_name, :father_contact, :mother_contact, :mobile, :alternate_mobile, :before_rent_address, :permanent_address, :postal_code, :district, :state, :country, :occupation, :occupation_contact, :occupation_address, :document_type, :document_number,:document_file, :profile_photo, :vehicle_no, :no_of_partners, :rent_start_date, :rent_end_date, :status])
  end

  def set_house
    @house = House.find(params[:house_id])
  end

  def set_house_room
    @house_room = HouseRoom.find(params[:house_room_id])
  end

  def set_tenant
    @tenant = Tenant.find_by(id: params[:id])
  end
end
