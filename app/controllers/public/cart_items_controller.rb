class Public::CartItemsController < ApplicationController
  def index
    @cart_items = current_customer.cart_items
  end

  def create
    @cart_items = current_customer.cart_items
    @product = Product.find(params[:cart_item][:product_id])

    if @cart_items.exists?(product: @product)
      existing_cart_item = @cart_items.find_by(product: @product)
      quantity = params[:cart_item][:quantity].to_i
      existing_cart_item.quantity += quantity

      if existing_cart_item.save
        flash[:success] = "商品をカートに追加しました。"
      else
        flash[:error] = "商品の追加に失敗しました。"
      end
    else
      @cart_item = @cart_items.build(cart_item_params) # カートアイテムを新たに作成する
      @cart_item.quantity = params[:cart_item][:quantity] # 数量を設定
      if @cart_item.save
        flash[:success] = "商品をカートに追加しました。"
      else
        flash[:error] = "商品の追加に失敗しました。"
      end
    end

    redirect_to cart_items_path
  end
  
  def update
    cart_item = CartItem.find(params[:id])
    quantity = params[:cart_item][:quantity].to_i

  if quantity > 0
    cart_item.update(quantity: quantity)
    flash[:success] = "数量が更新されました。"
  else
    cart_item.destroy
    flash[:success] = "カートアイテムが削除されました。"
  end

  redirect_to cart_items_path
end

  
  def destroy
    @cart_items = current_customer.cart_items
    @cart_item = @cart_items.find(params[:id])
    @cart_item.destroy

    flash[:success] = "商品をカートから削除しました。"
    redirect_to cart_items_path
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:product_id, :quantity)
  end
end

