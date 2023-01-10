class PhoneNumber < ApplicationRecord

  validates :number, presence: true,
            numericality: true,
            length: {minimum: 10}

end
