class Address < ApplicationRecord
  belongs_to :customer

  def post_code_and_address_and_name
    "〒#{self.post_code}  #{self.address}  #{self.name}"
  end

  validates :post_code, presence: true, length: {is: 7}
  validates :address, presence: true, length: { in: 1..48 }
  validates :name, presence: true, length: { in: 1..32 }

end
