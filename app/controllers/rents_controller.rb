class RentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_context
  before_action :set_rent, only: [:show, :edit, :update, :destroy]

  def index
    @rents = @tenant.rents.order(created_at: :desc)
  end

  def show
  end

  def new
    @rent = @tenant.rents.new(rent_amount: @house_room.rent)
  end

  def create
    @rent = @tenant.rents.new(rent_params)
    if @rent.save
      redirect_to house_house_room_tenant_rents_path(@house, @house_room, @tenant), notice: 'Rent record created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @rent.update(rent_params)
      redirect_to house_house_room_tenant_rent_path(@house, @house_room, @tenant, @rent), notice: 'Rent record updated.'
    else
      render :edit
    end
  end

  def destroy
    @rent.destroy
    redirect_to house_house_room_tenant_rents_path(@house, @house_room, @tenant), notice: 'Rent record deleted.'
  end

  private

  def set_context
    @house      = current_user.houses.find(params[:house_id])
    @house_room = @house.house_rooms.find(params[:house_room_id])
    @tenant     = @house_room.tenants.find(params[:tenant_id])
  end

  def set_rent
    @rent = @tenant.rents.find(params[:id])
  end

  def rent_params
    params.require(:rent).permit(:month, :rent_amount, :electricity_share, :total_amount, :paid_amount, :due_amount, :status)
  end
end
