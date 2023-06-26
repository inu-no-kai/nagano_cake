class Order < ApplicationRecord
  enum payment_method: { credit_card: 0, transfer: 1 }
  def address_display
  '〒' + postal_code + ' ' + delivery_address + ' ' + delivery_name
  end
end
