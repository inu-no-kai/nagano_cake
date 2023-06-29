class Order < ApplicationRecord
  has_many :order_details
  has_many :products, through: :order_details
  belongs_to :customer
  enum payment_method: { credit_card: 0, transfer: 1 }
  enum order_status: { waiting_payment: 0, payment_confirmation:1, in_production:2, shipping_preparation:3, sent:4}
  def address_display
  '〒' + postal_code + ' ' + delivery_address + ' ' + delivery_name
  end
end