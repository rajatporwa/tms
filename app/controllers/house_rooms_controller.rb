class HouseRoomsController < ApplicationController
	before_action :authenticate_user!
	before_action :set_room, only: %i[ show edit update]

	def index
		@house_rooms = HouseRoom.all
	end

	def new
		@houseroom = HouseRoom.new
	end

	def create
		
	end

	def edit
	end

	def update
	end

	def show
	end

	def destroy
	end

	private

	def set_room
		@room  = Room.find(params[:id])
	end

	def room_params
		params.expect(room: [ :house_id :room_number, :rent, :status, :month_of_rent, :previous_month_electricity_reading, :current_month_electricity_reading, :electricity_bill, :total_amount, :paid_status ])
	end
end
