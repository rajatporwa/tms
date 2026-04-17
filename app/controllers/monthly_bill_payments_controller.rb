class MonthlyBillPaymentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_context
  before_action :set_payment, only: [:edit, :update, :destroy]

  def index
    @payments = @monthly_bill.payments.order(payment_date: :desc)
  end

  def new
    @payment = @monthly_bill.payments.new(payment_date: Date.today)
  end

  def create
    @payment = @monthly_bill.payments.new(payment_params)
    @payment.tenant = @tenant
    if @payment.save
      redirect_to house_house_room_path(@house, @house_room), notice: 'Payment recorded successfully.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @payment.update(payment_params)
      redirect_to house_house_room_tenant_monthly_bill_payments_path(@house, @house_room, @tenant, @monthly_bill), notice: 'Payment updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @payment.destroy
    redirect_to house_house_room_tenant_monthly_bill_payments_path(@house, @house_room, @tenant, @monthly_bill), notice: 'Payment deleted.'
  end

  private

  def set_context
    @house        = current_user.houses.find(params[:house_id])
    @house_room   = @house.house_rooms.find(params[:house_room_id])
    @tenant       = @house_room.tenants.find(params[:tenant_id])
    @monthly_bill = @tenant.monthly_bills.find(params[:monthly_bill_id])
  end

  def set_payment
    @payment = @monthly_bill.payments.find(params[:id])
  end

  def payment_params
    params.require(:payment).permit(:amount, :payment_date, :payment_mode, :transaction_id, :note)
  end
end
