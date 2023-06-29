class OrderDetail < ApplicationRecord
  belongs_to :product
  belongs_to :order

  enum making_status: { do_not_start: 0, waiting_product: 1, producting: 2, completed_product: 3 }
end
