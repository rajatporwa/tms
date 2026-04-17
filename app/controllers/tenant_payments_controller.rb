class TenantPaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_context

  def index
    # We load payments that belong to this tenant.
    @payments = @tenant.payments.order(payment_date: :desc)
    
    @total_billed = @tenant.monthly_bills.sum(:total_amount)
    @total_paid = @tenant.payments.sum(:amount)
    @net_due = @total_billed - @total_paid
  end

  def new
    @payment = @tenant.payments.new(payment_date: Date.today)
  end

  def create
    @payment = @tenant.payments.new(payment_params)
    if @payment.save
      redirect_to house_house_room_tenant_payments_path(@house, @house_room, @tenant), notice: 'Tenant payment recorded successfully.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @payment = @tenant.payments.find(params[:id])
    @payment.destroy
    redirect_to house_house_room_tenant_payments_path(@house, @house_room, @tenant), notice: 'Payment deleted.'
  end

  private

  def set_context
    @house      = current_user.houses.find(params[:house_id])
    @house_room = @house.house_rooms.find(params[:house_room_id])
    @tenant     = @house_room.tenants.find(params[:tenant_id])
  end

  def payment_params
    params.require(:payment).permit(:amount, :payment_date, :payment_mode, :transaction_id, :note, :monthly_bill_id)
  end
end
