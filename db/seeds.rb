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

# Link roles and permissions
RolePermission.create!(
  role_id: superadmin_role.id,
  permission_id: view_dash.id
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
