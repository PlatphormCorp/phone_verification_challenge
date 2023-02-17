class Phone < ApplicationRecord
  SUPPORTED_COUNTRIES = [:us, :ca].freeze

  has_many :verification_codes

  validates :number, presence: true
  validates :number, phone: { countries: SUPPORTED_COUNTRIES }
end
