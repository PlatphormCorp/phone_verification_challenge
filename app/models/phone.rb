class Phone < ApplicationRecord
  has_many :phone_number_verifications
  validates :number, phone: true

  def create_and_verify
    ActiveRecord::Base.transaction do
      save!
      verification = self.phone_number_verifications.create!
      VerifyClient.new(phone_number: verify_client_number, verification_message: verification.verification_message).send_verification
    end

    self
  rescue ActiveRecord::RecordInvalid => e
    record_type = e.record.class.to_s
    message = "#{record_type} #{e.message}".humanize
    errors.add(:base, message)
    false
  rescue StandardError => e
    errors.add(:base, e.message)
    false
  end

  def verify_client_number
    number.gsub(/[^\d]/, '')
  end
end
