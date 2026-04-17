class CreateVehicles < ActiveRecord::Migration[7.2]
  def change
    create_table :vehicles do |t|
      t.string :vehicle_name
      t.string :vehicle_no
      t.references :owner, polymorphic: true, null: false

      t.timestamps
    end
  end
end
