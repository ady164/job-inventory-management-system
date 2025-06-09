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

# Create roles
superadmin_role = Role.create!(name: "Super Admin")
admin_role       = Role.create!(name: "Admin")
technician_role  = Role.create!(name: "Technician")

# Create permission
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


# Link roles and permissions
# SUPER ADMIN permissions
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
# ADMIN permissions
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

# Create users
User.create!(
  name: "deyao",
  email: "deyao@jims.com",
  password_hash: sha256("12345678"),
  pin_hash: sha256("123456"),
  role_id: superadmin_role.id
)

User.create!(
  name: "Admin",
  email: "admin@jims.com",
  password_hash: sha256("admin123"),
  pin_hash: sha256("111111"),
  role_id: admin_role.id
)

User.create!(
  name: "Technician 1",
  email: "tech1@jims.com",
  password_hash: sha256("tech123"),
  pin_hash: sha256("222222"),
  role_id: technician_role.id
)

# Create Inventory Item
Inventory.create!(
  name: "DNMG 15 06 08-MF 1115",
  product_number: "DNMG 15 06 08-MF 1115",
  brand: "Sanvik",
  description: "Sanvik Turning Insert",
  category: "Inserts",
  quantity: 0,
  alert_quantity: 5,
  status: "Available"
  )
Inventory.create!(
  name: "DNMG 15 06 04-MF 1115",
  product_number: "DNMG 15 06 04-MF 1115",
  brand: "Sanvik",
  description: "Sanvik Turning Insert",
  category: "Inserts",
  quantity: 0,
  alert_quantity: 5,
  status: "Available"
  )
Inventory.create!(
  name: "VBMT 16 04 08-UM 1125",
  product_number: "VBMT 16 04 08-UM 1125",
  brand: "Sanvik",
  description: "Sanvik Turning Insert",
  category: "Inserts",
  quantity: 0,
  alert_quantity: 5,
  status: "Available"
  )
Inventory.create!(
  name: "VBMT 16 04 04-UM 1125",
  product_number: "VBMT 16 04 04-UM 1125",
  brand: "Sanvik",
  description: "Sanvik Turning Insert",
  category: "Inserts",
  quantity: 0,
  alert_quantity: 5,
  status: "Available"
  )