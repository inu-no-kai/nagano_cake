class Public::ProductsController < ApplicationController
  
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end
  
  private
  
  def product_params
    params.require(:product).permit(:price, :name, :description, :image)
  end
  
end
