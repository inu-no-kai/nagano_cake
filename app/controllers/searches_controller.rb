class SearchesController < ApplicationController
 def search
    @products = Product.where("name LIKE?","%#{word}%")
    if @products.count == 0
        @products = Product.all
    end
 end
end
