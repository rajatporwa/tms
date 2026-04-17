class DashboardController < ApplicationController
  before_action :authenticate_user!
  
  def owner
    if current_user.owner?
      @houses = current_user.houses.includes(:house_rooms)
      @total_rooms = @houses.sum(:no_of_rooms)
      @occupied_rooms = @houses.flat_map(&:house_rooms).count { |r| r.status == "occupied" }
      @vacant_rooms = @total_rooms - @occupied_rooms
      @pending_rents = Rent.joins(tenant: :house_room).where(house_rooms: { house_id: @houses.pluck(:id) }).where.not(status: "paid")
      @total_pending_amount = @pending_rents.sum(:due_amount)
    else
      redirect_to root_path, alert: "Access Denied"
    end
  end
end
