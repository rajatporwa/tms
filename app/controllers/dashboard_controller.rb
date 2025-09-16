class DashboardController < ApplicationController
  before_action :authenticate_user!
  
  def owner
    if current_user.owner?
      @houses = current_user.houses.includes(images_attachements: :blob)
    else
      redirect_to root_path, alert: "Access Denied"
    end
  end
end
