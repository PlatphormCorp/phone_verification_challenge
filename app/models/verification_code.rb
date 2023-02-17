class VerificationCode < ApplicationRecord
  belongs_to :phone

  validates :code, presence: true

  scope :active, -> { where("expires_at > ?", Time.now) }
end
