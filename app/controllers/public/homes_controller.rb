class Public::HomesController < ApplicationController

  def top
    @products = Product.all.order(created_at: :desc).limit(4)
    #created_at: :descで新着順にできる　limit(4)で4つまで限定で商品を引っ張てくることができる
  end

  def about
  end
end
