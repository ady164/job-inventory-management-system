class Role < ApplicationRecord
  has_many :users
  has_many :role_permissions
  has_many :permissions, through: :role_permissions
end