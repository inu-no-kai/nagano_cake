class Product < ApplicationRecord
  has_one_attached :image
  belongs_to :genre
  has_many :order_details
  has_many :cart_items
  # def get_image(width, height)
  # unless image.attached?
  #   file_path = Rails.root.join('app/assets/images/no_image.jpg')
  #   image.attach(io: File.open(file_path), filename: 'no_ima.jpg', content_type: 'image/jpg')
  # end
  # image.variant(resize_to_limit: [width, height]).processed
  # end


  def get_image(width, height)
  unless image.attached?
    file_path = Rails.root.join('app/assets/images/no_image.jpg')
    image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpg')
  end
    image
  end
end
