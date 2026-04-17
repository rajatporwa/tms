# Migration script to move vehicle_no to Vehicles table
Tenant.all.each do |tenant|
  if tenant.vehicle_no.present?
    tenant.vehicles.create!(vehicle_no: tenant.vehicle_no, vehicle_name: "Primary Vehicle")
  end
end

TenantPartner.all.each do |partner|
  if partner.vehicle_no.present?
    partner.vehicles.create!(vehicle_no: partner.vehicle_no, vehicle_name: "Partner Vehicle")
  end
end
puts "Data migration complete."
