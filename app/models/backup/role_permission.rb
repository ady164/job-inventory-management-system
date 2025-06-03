class RolePermission < ApplicationRecord
  self.table_name = "role_permission" # because plural would be "role_permissions"
  belongs_to :role
  belongs_to :permission
end
