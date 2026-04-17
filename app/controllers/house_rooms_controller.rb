class HouseRoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_house
  before_action :set_room, only: %i[show edit update destroy]

  def index
    @house_rooms = @house.house_rooms.order(:room_number)
  end

  def new
    @house_room = @house.house_rooms.new
  end

  def create
    @house_room = @house.house_rooms.new(room_params)
    if @house_room.save
      redirect_to house_path(@house), notice: "Room created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @house_room.update(room_params)
      redirect_to house_house_room_path(@house, @house_room), notice: "Room updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
    @tenants = @house_room.tenants.order(created_at: :desc)
    @active_tenant = @house_room.tenants.find_by(status: 'active')
  end

  def destroy
    @house_room.destroy
    redirect_to house_path(@house), notice: "Room deleted."
  end

  private

  def set_house
    @house = current_user.houses.find(params[:house_id])
  end

  def set_room
    @house_room = @house.house_rooms.find(params[:id])
  end

  def room_params
    params.require(:house_room).permit(:room_number, :rent, :status)
  end
end
