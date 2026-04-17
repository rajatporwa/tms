class PaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_context
  before_action :set_payment, only: [:show, :edit, :update, :destroy]

  def index
    @payments = @rent.payments.order(payment_date: :desc)
  end

  def show
  end

  def new
    @payment = @rent.payments.new(payment_date: Date.today)
  end

  def create
    @payment = @rent.payments.new(payment_params)
    @payment.tenant = @tenant
    if @payment.save
      redirect_to house_house_room_tenant_rent_path(@house, @house_room, @tenant, @rent), notice: 'Payment recorded.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @payment.update(payment_params)
      redirect_to house_house_room_tenant_rent_path(@house, @house_room, @tenant, @rent), notice: 'Payment updated.'
    else
      render :edit
    end
  end

  def destroy
    @payment.destroy
    redirect_to house_house_room_tenant_rent_path(@house, @house_room, @tenant, @rent), notice: 'Payment deleted.'
  end

  private

  def set_context
    @house      = current_user.houses.find(params[:house_id])
    @house_room = @house.house_rooms.find(params[:house_room_id])
    @tenant     = @house_room.tenants.find(params[:tenant_id])
    @rent       = @tenant.rents.find(params[:rent_id])
  end

  def set_payment
    @payment = @rent.payments.find(params[:id])
  end

  def payment_params
    params.require(:payment).permit(:amount, :payment_date, :payment_mode, :transaction_id, :note)
  end
end
