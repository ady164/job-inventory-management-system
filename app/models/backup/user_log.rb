class UserLog < ApplicationRecord
  belongs_to :user, optional: true
  validates :login_email, presence: true
  validates :message, presence: true
end
