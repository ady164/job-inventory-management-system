require 'digest'

class User < ApplicationRecord
  belongs_to :role
  has_many :user_logs

  # Store SHA256 password hash in password_hash column
  def password=(plain_password)
    self.password_hash = Digest::SHA256.hexdigest(plain_password)
  end

  def authenticate(plain_password)
    Digest::SHA256.hexdigest(plain_password) == self.password_hash
  end

  def has_permission?(perm_name)
    role.permissions.exists?(name: perm_name)
  end
end
