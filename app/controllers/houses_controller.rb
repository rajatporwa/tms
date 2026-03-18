class HousesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_house, only: %i[show edit update destroy]

  def index
    @houses = current_user.houses
  end

  def show
  end

  def new
    @house = current_user.houses.new
  end

  def create
    @house = current_user.houses.new(house_params)
    if @house.save
      redirect_to houses_path, notice: "House created successfully"
    else
      render :new
    end
  end

	def edit
	end

  def update
    if @house.update(house_params)
      redirect_to houses_path, notice: "House updated successfully"
    else
      render :edit
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
    params.require(:house).permit(:house_name, :address, :owner_name, :owner_id, :no_of_rooms, house_images: [])
  end
end
