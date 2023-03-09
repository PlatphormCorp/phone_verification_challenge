class VerifyPhone < ApplicationRecord
    before_validation :clean_number
    
      enum status: {
        unverified: 0,
        pending: 1,
        verified: 2
    }

    validates :number, presence: true, uniqueness: true, length: { is: 10 }

    def clean_number
        self.number = number.gsub(/^\+1/, "").gsub(/\D/, '')
    end

    def generate_code
        self.verification_code = rand(100000..999999).to_s
        save
    end
end
