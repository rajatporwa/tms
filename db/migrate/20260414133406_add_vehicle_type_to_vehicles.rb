class AddVehicleTypeToVehicles < ActiveRecord::Migration[7.2]
  def change
    add_column :vehicles, :vehicle_type, :string
  end
end
