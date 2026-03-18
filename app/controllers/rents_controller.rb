class RentsController < ApplicationController
  before_action :set_tenant, only: [:new, :create, :index]
  before_action :set_rent, only: [:show, :edit, :update, :destroy]

  def index
    @rents = @tenant.rents.order(created_at: :desc)
  end

  def show
  end

  def new
    @rent = @tenant.rents.new
  end

  def create
    @rent = @tenant.rents.new(rent_params)
    if @rent.save
      redirect_to tenant_rents_path(@tenant), notice: 'Rent record created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @rent.update(rent_params)
      redirect_to tenant_rents_path(@rent.tenant), notice: 'Rent record updated.'
    else
      render :edit
    end
  end

  def destroy
    @rent.destroy
    redirect_to tenant_rents_path(@rent.tenant), notice: 'Rent record deleted.'
  end

  private

  def set_tenant
    @tenant = Tenant.find(params[:tenant_id])
  end

  def set_rent
    @rent = Rent.find(params[:id])
  end

  def rent_params
    params.require(:rent).permit(:month, :rent_amount, :electricity_share, :total_amount, :paid_amount, :due_amount, :status)
  end
end
