# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'digest'

# Helper for SHA256 hashing
def sha256(string)
  Digest::SHA256.hexdigest(string)
end

# ================= CREATE ROLES ================= 
superadmin_role = Role.create!(name: "Super Admin")
admin_role       = Role.create!(name: "Admin")
technician_role  = Role.create!(name: "Technician")

# ================= CREATE PERMISSIONS ================= 
view_dash = Permission.create!(
  name: "view_dashboard",
  description: "View dashboard"
)
view_admin = Permission.create!(
  name: "view_admin",
  description: "View admin(Users and Roles)"
)
create_admin = Permission.create!(
  name: "create_admin",
  description: "Create admin(Users and Roles)"
)
edit_admin = Permission.create!(
  name: "edit_admin",
  description: "Edit admin(Users and Roles)"
)
delete_admin = Permission.create!(
  name: "delete_admin",
  description: "Delete admin(Users and Roles)"
)
view_inventory = Permission.create!(
  name: "view_inventory",
  description: "View inventory"
)
create_inventory = Permission.create!(
  name: "create_inventory",
  description: "Create inventory"
)
edit_inventory = Permission.create!(
  name: "edit_inventory",
  description: "Edit inventory"
)
delete_inventory = Permission.create!(
  name: "delete_inventory",
  description: "Delete inventory"
)
view_customer = Permission.create!(
  name: "view_customer",
  description: "View customer"
)
create_customer = Permission.create!(
  name: "create_customer",
  description: "Create customer"
)
edit_customer = Permission.create!(
  name: "edit_customer",
  description: "Edit customer"
)
delete_customer = Permission.create!(
  name: "delete_customer",
  description: "Delete customer"
)
view_job = Permission.create!(
  name: "view_job",
  description: "View job"
)
create_job = Permission.create!(
  name: "create_job",
  description: "Create job"
)
edit_job = Permission.create!(
  name: "edit_job",
  description: "Edit job"
)
delete_job = Permission.create!(
  name: "delete_job",
  description: "Delete job"
)
view_equipment = Permission.create!(
  name: "view_equipment",
  description: "View equipment"
)
create_equipment = Permission.create!(
  name: "create_equipment",
  description: "Create equipment"
)
edit_equipment = Permission.create!(
  name: "edit_equipment",
  description: "Edit equipment"
)
delete_equipment = Permission.create!(
  name: "delete_equipment",
  description: "Delete equipment"
)
maintain_equipment = Permission.create!(
  name: "maintain_equipment",
  description: "Maintain equipment"
)
view_jobprocesses = Permission.create!(
  name: "view_jobprocess",
  description: "view_jobprocess"
)

# ================= LINK ROLES TO PERMISSIONS ================= 
# ================= SUPER ADMIN permissions ================= 
RolePermission.create!(
  role_id: superadmin_role.id,
  permission_id: view_dash.id
)
#  ------ Admin Page -----------
RolePermission.create!(
  role_id: superadmin_role.id,
  permission_id: view_admin.id
)
RolePermission.create!(
  role_id: superadmin_role.id,
  permission_id: create_admin.id
)
RolePermission.create!(
  role_id: superadmin_role.id,
  permission_id: edit_admin.id
)
RolePermission.create!(
  role_id: superadmin_role.id,
  permission_id: delete_admin.id
)
#  ------ Inventory Page -----------
RolePermission.create!(
  role_id: superadmin_role.id,
  permission_id: view_inventory.id
)
RolePermission.create!(
  role_id: superadmin_role.id,
  permission_id: create_inventory.id
)
RolePermission.create!(
  role_id: superadmin_role.id,
  permission_id: edit_inventory.id
)
RolePermission.create!(
  role_id: superadmin_role.id,
  permission_id: delete_inventory.id
)
#  ------ Customer Page -----------
RolePermission.create!(
  role_id: superadmin_role.id,
  permission_id: view_customer.id
)
RolePermission.create!(
  role_id: superadmin_role.id,
  permission_id: create_customer.id
)
RolePermission.create!(
  role_id: superadmin_role.id,
  permission_id: edit_customer.id
)
RolePermission.create!(
  role_id: superadmin_role.id,
  permission_id: delete_customer.id
)
#  ------ Equipments Page -----------
RolePermission.create!(
  role_id: superadmin_role.id,
  permission_id: view_equipment.id
)
RolePermission.create!(
  role_id: superadmin_role.id,
  permission_id: create_equipment.id
)
RolePermission.create!(
  role_id: superadmin_role.id,
  permission_id: edit_equipment.id
)
RolePermission.create!(
  role_id: superadmin_role.id,
  permission_id: delete_equipment.id
)
RolePermission.create!(
  role_id: superadmin_role.id,
  permission_id: maintain_equipment.id
)
#  ------ Jobs Page -----------
RolePermission.create!(
  role_id: superadmin_role.id,
  permission_id: view_job.id
)
RolePermission.create!(
  role_id: superadmin_role.id,
  permission_id: create_job.id
)
RolePermission.create!(
  role_id: superadmin_role.id,
  permission_id: edit_job.id
)
RolePermission.create!(
  role_id: superadmin_role.id,
  permission_id: delete_job.id
)
RolePermission.create!(
  role_id: superadmin_role.id,
  permission_id: view_jobprocesses.id
)

# ================= ADMIN permissions ================= 
RolePermission.create!(
  role_id: admin_role.id,
  permission_id: view_dash.id
)
RolePermission.create!(
  role_id: admin_role.id,
  permission_id: view_admin.id
)
RolePermission.create!(
  role_id: admin_role.id,
  permission_id: create_admin.id
)
RolePermission.create!(
  role_id: admin_role.id,
  permission_id: edit_admin.id
)
#  ------ Inventory Page -----------
RolePermission.create!(
  role_id: admin_role.id,
  permission_id: view_inventory.id
)
RolePermission.create!(
  role_id: admin_role.id,
  permission_id: create_inventory.id
)
RolePermission.create!(
  role_id: admin_role.id,
  permission_id: edit_inventory.id
)
RolePermission.create!(
  role_id: admin_role.id,
  permission_id: delete_inventory.id
)
#  ------ Customer Page -----------
RolePermission.create!(
  role_id: admin_role.id,
  permission_id: view_customer.id
)
RolePermission.create!(
  role_id: admin_role.id,
  permission_id: create_customer.id
)
RolePermission.create!(
  role_id: admin_role.id,
  permission_id: edit_customer.id
)
RolePermission.create!(
  role_id: admin_role.id,
  permission_id: delete_customer.id
)
#  ------ Equipments Page -----------
RolePermission.create!(
  role_id: admin_role.id,
  permission_id: view_equipment.id
)
RolePermission.create!(
  role_id: admin_role.id,
  permission_id: create_equipment.id
)
RolePermission.create!(
  role_id: admin_role.id,
  permission_id: edit_equipment.id
)
RolePermission.create!(
  role_id: admin_role.id,
  permission_id: delete_equipment.id
)
RolePermission.create!(
  role_id: admin_role.id,
  permission_id: maintain_equipment.id
)
#  ------ Jobs Page -----------
RolePermission.create!(
  role_id: admin_role.id,
  permission_id: view_job.id
)
RolePermission.create!(
  role_id: admin_role.id,
  permission_id: create_job.id
)
RolePermission.create!(
  role_id: admin_role.id,
  permission_id: edit_job.id
)
RolePermission.create!(
  role_id: admin_role.id,
  permission_id: delete_job.id
)
RolePermission.create!(
  role_id: admin_role.id,
  permission_id: view_jobprocesses.id
)
# ================= Technician permissions ================= 
RolePermission.create!(
  role_id: technician_role.id,
  permission_id: view_dash.id
)
#  ------ Inventory Page -----------
RolePermission.create!(
  role_id: technician_role.id,
  permission_id: view_inventory.id
)
#  ------ Jobs Page -----------
RolePermission.create!(
  role_id: technician_role.id,
  permission_id: view_job.id
)
RolePermission.create!(
  role_id: technician_role.id,
  permission_id: create_job.id
)
RolePermission.create!(
  role_id: technician_role.id,
  permission_id: edit_job.id
)
RolePermission.create!(
  role_id: technician_role.id,
  permission_id: view_jobprocesses.id
)


# ================= CREATE USERS ================= 
user1 = User.create!(
  name: "deyao",
  email: "deyao@jims.com",
  password_hash: sha256("12345678"),
  pin_hash: sha256("123456"),
  role_id: superadmin_role.id
)

user2 = User.create!(
  name: "Admin",
  email: "admin@jims.com",
  password_hash: sha256("admin123"),
  pin_hash: sha256("111111"),
  role_id: admin_role.id
)

user3 = User.create!(
  name: "Technician 1",
  email: "tech1@jims.com",
  password_hash: sha256("tech123"),
  pin_hash: sha256("222222"),
  role_id: technician_role.id
)

# ================= CREATE INVENTORY ITEMS ================= 
Inventory.create!(
  name: "DNMG 15 06 08-MF 1115",
  product_number: "DNMG 15 06 08-MF 1115",
  brand: "Sanvik",
  description: "Sanvik Turning Insert",
  category: "Inserts",
  quantity: 0,
  alert_quantity: 5,
  status: "Available",
  image_path: "/uploads/e82eb792-6814-4e44-9f67-141b7d6e24a3_Sanvik DNMG.png",
  unit_cost: 13.56
  )
Inventory.create!(
  name: "DNMG 15 06 04-MF 1115",
  product_number: "DNMG 15 06 04-MF 1115",
  brand: "Sanvik",
  description: "Sanvik Turning Insert",
  category: "Inserts",
  quantity: 0,
  alert_quantity: 5,
  status: "Available",
  image_path: "/uploads/e82eb792-6814-4e44-9f67-141b7d6e24a3_Sanvik DNMG.png",
  unit_cost: 13.56
  )
Inventory.create!(
  name: "VBMT 16 04 08-UM 1125",
  product_number: "VBMT 16 04 08-UM 1125",
  brand: "Sanvik",
  description: "Sanvik Turning Insert",
  category: "Inserts",
  quantity: 0,
  alert_quantity: 5,
  status: "Available",
  image_path: "/uploads/075ec22a-c8c0-42cb-bc86-7953f91c4442_Sanvik VBMT.png",
  unit_cost: 16.58
  )
Inventory.create!(
  name: "VBMT 16 04 04-UM 1125",
  product_number: "VBMT 16 04 04-UM 1125",
  brand: "Sanvik",
  description: "Sanvik Turning Insert",
  category: "Inserts",
  quantity: 0,
  alert_quantity: 5,
  status: "Available",
  image_path: "/uploads/075ec22a-c8c0-42cb-bc86-7953f91c4442_Sanvik VBMT.png",
  unit_cost: 16.58
  )

Inventory.create!(
  name: "DNMG 150408 RP",
  product_number: "DNMG 150408 RP",
  brand: "Kennametal",
  description: "Turning Insert",
  category: "Inserts",
  quantity: 0,
  alert_quantity: 5,
  status: "Available",
  image_path: "/uploads/78312b93-1bce-4aa6-a4f4-ccfa6dfda370_KM DNMG.jpg",
  unit_cost: 16.58
  )
Inventory.create!(
  name: "DNMG 150404 RP",
  product_number: "DNMG 150404 RP",
  brand: "Kennametal",
  description: "Turning Insert",
  category: "Inserts",
  quantity: 0,
  alert_quantity: 5,
  status: "Available",
  image_path: "/uploads/78312b93-1bce-4aa6-a4f4-ccfa6dfda370_KM DNMG.jpg",
  unit_cost: 16.58
  )
Inventory.create!(
  name: "DNMG 1",
  product_number: "DNMG 1",
  brand: "Kennametal",
  description: "Turning Insert",
  category: "Inserts",
  quantity: 0,
  alert_quantity: 5,
  status: "Available",
  image_path: "/uploads/78312b93-1bce-4aa6-a4f4-ccfa6dfda370_KM DNMG.jpg",
  unit_cost: 16.58
  )
Inventory.create!(
  name: "DNMG 2",
  product_number: "DNMG 2",
  brand: "Kennametal",
  description: "Turning Insert",
  category: "Inserts",
  quantity: 0,
  alert_quantity: 5,
  status: "Available",
  image_path: "/uploads/78312b93-1bce-4aa6-a4f4-ccfa6dfda370_KM DNMG.jpg",
  unit_cost: 16.58
  )
Inventory.create!(
  name: "VBMT 1",
  product_number: "VBMT 1",
  brand: "Sanvik",
  description: "Sanvik Turning Insert",
  category: "Inserts",
  quantity: 0,
  alert_quantity: 5,
  status: "Available",
  image_path: "/uploads/075ec22a-c8c0-42cb-bc86-7953f91c4442_Sanvik VBMT.png",
  unit_cost: 16.58
  )
Inventory.create!(
  name: "VBMT 1",
  product_number: "VBMT 1",
  brand: "Sanvik",
  description: "Sanvik Turning Insert",
  category: "Inserts",
  quantity: 0,
  alert_quantity: 5,
  status: "Available",
  image_path: "/uploads/075ec22a-c8c0-42cb-bc86-7953f91c4442_Sanvik VBMT.png",
  unit_cost: 16.58
  )


# ================= CREATE CUSTOMERS ================= 
customer1 = Customer.create!(
  name: "Goltens Singapore",
  address: "6A Benoi Rd, Singapore 629881"
  )
customer2 = Customer.create!(
  name: "Raffles Shipmanagement Services",
  address: "28 Biopolis Rd, Singapore 138568"
  )
customer3 = Customer.create!(
  name: "Megawatts Engineering Services",
  address: "10 Kian Teck Wy, Singapore 628747"
  )
customer4 = Customer.create!(
  name: "Diethelm Marine Diesel",
  address: "59 & 61, Jln Alam Jaya 1, Taman Perindustrian Alam Jaya, 81500 Pekan Nanas, Johor, Malaysia"
  )
customer5 = Customer.create!(
  name: "Sulzer Singapore",
  address: "438 Alexandra Rd, #02-01/06 Alexandra Technopark, Singapore 119968"
  )
customer6 = Customer.create!(
  name: "Schottel Far East",
  address: "4 Tech Park Cres, Tech Park, Singapore 638128"
  )

# ================= CREATE EQUIPMENTS ================= 
Equipment.create!(
  name: "Shenyang Lathe Machine (1m x 5m)",
  tag: "Lathe #1",
  brand: "YAWO Machinery",
  model: "Cw6280",
  serial_number: "SN123Cw6280",
  equipment_type: "Machine",
  purchase_date: Date.new(2020, 5, 1),
  remarks: "Max Load: 3000kg",
  last_calibration_date: Date.new(2025, 5, 5),
  calibration_frequency_days: 30
)
Equipment.create!(
  name: "Laser Plant 1",
  tag: "Laser #1",
  brand: "Trumpf",
  model: "LS1234",
  serial_number: "LS12345678",
  equipment_type: "Machine",
  purchase_date: Date.new(2021, 5, 1),
  remarks: "5000h runtime",
  last_calibration_date: Date.new(2025, 5, 5),
  calibration_frequency_days: 30
)
Equipment.create!(
  name: "Laser Plant 2",
  tag: "Laser #2",
  brand: "Trumpf",
  model: "LS1234",
  serial_number: "LS98765432",
  equipment_type: "Machine",
  purchase_date: Date.new(2022, 1, 10),
  remarks: "5000h runtime",
  last_calibration_date: Date.new(2025, 5, 5),
  calibration_frequency_days: 30
)
Equipment.create!(
  name: "Bosch Band Saw",
  tag: "BandSaw #1",
  brand: "Bosch",
  model: "BS-500",
  serial_number: "SN321BS500",
  equipment_type: "Machine",
  purchase_date: Date.new(2022, 10, 10),
  remarks: "Metal cutting band saw",
  last_calibration_date: Date.new(2025, 10, 10),
  calibration_frequency_days: 180
)
Equipment.create!(
  name: "FANUC CNC Milling Machine",
  tag: "Milling #1",
  brand: "FANUC",
  model: "FMC-1000",
  serial_number: "SN456FMC1000",
  equipment_type: "Machine",
  purchase_date: Date.new(2019, 3, 12),
  remarks: "Used for precision milling",
  last_calibration_date: Date.new(2024, 3, 12),
  calibration_frequency_days: 60
)
Equipment.create!(
  name: "Mitutoyo Digimatic Caliper 0-150mm",
  tag: "Caliper #1",
  brand: "Mitutoyo",
  model: "CD-6 CSX",
  serial_number: "SN123456",
  equipment_type: "Measuring Tools",
  purchase_date: Date.new(2023, 3, 15),
  remarks: "High precision digital caliper",
  last_calibration_date: Date.new(2025, 3, 15),
  calibration_frequency_days: 365
)
Equipment.create!(
  name: "Mitutoyo Digimatic Caliper 0-150mm",
  tag: "Caliper #2",
  brand: "Mitutoyo",
  model: "CD-6 CSX",
  serial_number: "SN123457",
  equipment_type: "Measuring Tools",
  purchase_date: Date.new(2023, 3, 15),
  remarks: "High precision digital caliper",
  last_calibration_date: Date.new(2025, 3, 15),
  calibration_frequency_days: 365
)
Equipment.create!(
  name: "Mitutoyo Height Gauge 0-300mm",
  tag: "HeightGauge #1",
  brand: "Mitutoyo",
  model: "192-225",
  serial_number: "SN789012",
  equipment_type: "Measuring Tools",
  purchase_date: Date.new(2021, 11, 5),
  remarks: "Scriber and dial indicator attachment",
  last_calibration_date: Date.new(2024, 11, 5),
  calibration_frequency_days: 365
)
Equipment.create!(
  name: "Mitutoyo Dial Indicator 0-10mm",
  tag: "DialInd #1",
  brand: "Mitutoyo",
  model: "2046S",
  serial_number: "SN345678",
  equipment_type: "Measuring Tools",
  purchase_date: Date.new(2020, 9, 10),
  remarks: "Shockproof dial indicator",
  last_calibration_date: Date.new(2023, 9, 10),
  calibration_frequency_days: 365
)
Equipment.create!(
  name: "Mitutoyo Bore Gauge 1-18mm",
  tag: "BoreGauge #1",
  brand: "Mitutoyo",
  model: "511-731",
  serial_number: "SN987654",
  equipment_type: "Measuring Tools",
  purchase_date: Date.new(2022, 1, 25),
  remarks: "Precision bore gauge with dial indicator",
  last_calibration_date: Date.new(2025, 1, 25),
  calibration_frequency_days: 365
)
Equipment.create!(
  name: "Makita Cordless Impact Driver",
  tag: "ImpactDriver #1",
  brand: "Makita",
  model: "DTD153Z",
  serial_number: "SN101IMPACT",
  equipment_type: "Power Tools",
  purchase_date: Date.new(2023, 2, 14),
  remarks: "18V LXT lithium-ion brushless driver",
  last_calibration_date: Date.new(2024, 2, 14),
  calibration_frequency_days: 365
)
Equipment.create!(
  name: "DeWalt Angle Grinder",
  tag: "Grinder #2",
  brand: "DeWalt",
  model: "DWE402",
  serial_number: "SN103GRIND",
  equipment_type: "Power Tools",
  purchase_date: Date.new(2022, 9, 5),
  remarks: "4.5-inch 11-amp angle grinder",
  last_calibration_date: Date.new(2024, 9, 5),
  calibration_frequency_days: 180
)
Equipment.create!(
  name: "Milwaukee Cordless Drill",
  tag: "Drill #1",
  brand: "Milwaukee",
  model: "M18 FUEL 2804-20",
  serial_number: "SN105DRILL",
  equipment_type: "Power Tools",
  purchase_date: Date.new(2023, 4, 18),
  remarks: "Brushless hammer drill with Redlink Plus intelligence",
  last_calibration_date: Date.new(2024, 4, 18),
  calibration_frequency_days: 365
)
Equipment.create!(
  name: "Auto Sandblasting Machine",
  tag: "Sandblast #1 (A)",
  brand: "Clemco",
  model: "AutoBlast X500",
  serial_number: "X500A762AUTO01",
  equipment_type: "Machine",
  purchase_date: Date.new(2023, 7, 10),
  remarks: "Automated sandblasting system with programmable blasting cycles",
  last_calibration_date: Date.new(2025, 5, 10),
  calibration_frequency_days: 180
)

Equipment.create!(
  name: "Sandblasting Machine",
  tag: "Sandblast #2 (M)",
  brand: "Graco",
  model: "BlastPro BP500",
  serial_number: "BP500SNJ1234"
  equipment_type: "Machine",
  purchase_date: Date.new(2022, 11, 5),
  remarks: "Manual pressure-feed sandblasting machine for small to medium surfaces",
  last_calibration_date: Date.new(2025, 2, 5),
  calibration_frequency_days: 180
)


# ================= CREATE JOB_PROCESS_TYPE ================= 
JobProcessType.create!(
  name: "INCOMING",
  sequence_index: 1
)
JobProcessType.create!(
  name: "PRE-MACHINING",
  sequence_index: 2
)
JobProcessType.create!(
  name: "SAND-BLASTING",
  sequence_index: 3
)
JobProcessType.create!(
  name: "CLADDING",
  sequence_index: 4
)
JobProcessType.create!(
  name: "FINAL MACHINING",
  sequence_index: 5
)

# ================= CREATE JOBS ================= 
job1 = Job.create!(
  customer_id: customer1.id,
  job_reference_number: "JIMS-PST-250614-001",
  vessle_name: nil,
  required_date: Date.new(2025, 6, 14),
  part_type: "Piston",
  part_model: "DK32",
  part_name: nil,
  base_material: "Cast Iron",
  filler_material: "Stellite 21",
  notes: nil,
  status: "Pending",
  created_by: user1.id
)
job2 = Job.create!(
  customer_id: customer2.id,
  job_reference_number: "JIMS-PST-250614-002",
  vessle_name: "Melati 6",
  required_date: Date.new(2025, 6, 14),
  part_type: "Piston",
  part_model: "N280",
  part_name: nil,
  base_material: "Cast Iron",
  filler_material: "Stellite 21",
  notes: nil,
  status: "Confirmed",
  created_by: user1.id
)
job3 = Job.create!(
  customer_id: customer3.id,
  job_reference_number: "JIMS-GNP-250614-001",
  vessle_name: nil,
  required_date: Date.new(2025, 6, 14),
  part_type: "General Part",
  part_model: nil,
  part_name: "Housing DE",
  base_material: "Cast Iron",
  filler_material: "SS316L",
  notes: "Allowed to use Inconel 625 as replacement filler material if base material condition is bad.",
  status: "Confirmed",
  created_by: user2.id
)
job4 = Job.create!(
  customer_id: customer3.id,
  job_reference_number: "JIMS-GNP-250614-002",
  vessle_name: nil,
  required_date: Date.new(2025, 6, 14),
  part_type: "General Part",
  part_model: nil,
  part_name: "Housing NDE",
  base_material: "Cast Iron",
  filler_material: "SS316L",
  notes: "Allowed to use Inconel 625 as replacement filler material if base material condition is bad.",
  status: "Confirmed",
  created_by: user2.id
)
job5 = Job.create!(
  customer_id: customer4.id,
  job_reference_number: "JIMS-TSS-250614-001",
  vessle_name: nil,
  required_date: Date.new(2025, 6, 14),
  part_type: "Turbo Shaft",
  part_model: "ST5",
  part_name: nil,
  base_material: "Steel",
  filler_material: "Inconel 625, Stellite 21",
  notes: "Inconel 625 for Seal Ring Groove and Stellite 21 for Bearing Journal.",
  status: "Confirmed",
  created_by: user2.id
)

# ================= CREATE JOB PROCESS ================= 

JobProcess.create!(
  job_process_type_id: 1,
  job_id: job1.id,
  order_index: 1,
  status: "Not Completed"
)
JobProcess.create!(
  job_process_type_id: 1,
  job_id: job2.id,
  order_index: 1,
  status: "Not Completed"
)
JobProcess.create!(
  job_process_type_id: 1,
  job_id: job3.id,
  order_index: 1,
  status: "Not Completed"
)
JobProcess.create!(
  job_process_type_id: 1,
  job_id: job4.id,
  order_index: 1,
  status: "Not Completed"
)
JobProcess.create!(
  job_process_type_id: 1,
  job_id: job5.id,
  order_index: 1,
  status: "Not Completed"
)
