class Public::OrdersController < ApplicationController
    def new
      # 新しい注文のインスタンスを作成
      @order = Order.new
    end
   
    def confirm
      if params[:order] [:select_address] == "0"
        @order = Order.new(order_params)
        @order.delivery_post_code = current_customer.post_code
        @order.delivery_address = current_customer.address
        @order.delivery_name = current_customer.first_name + current_customer.last_name
        
      elsif params[:order] [:select_address] == "1"
        @order = Order.new(order_params)
        @address = Address.find(params[:order][:address_id])
        @order.delivery_address = @address.address
        @order.delivery_post_code = @address.post_code
        @order.delivery_name = @address.name
      end
        @cart_items = current_customer.cart_items
    end
    
    def create
      # 注文の作成
      @order = Order.new(order_params)
      # 注文を保存するなどの処理を行う
      @order.postage = 800
      @order.customer_id = current_customer.id
      if @order.save
          @cart_items = current_customer.cart_items
          @cart_items.each do |cart_item|
          @order_detail = OrderDetail.new
          @order_detail.product_id = cart_item.product_id
          @order_detail.order_id = @order.id
          @order_detail.price = cart_item.product.price
          @order_detail.quantity = cart_item.quantity
          @order_detail.making_status = 0
          @order_detail.save
      end
          current_customer.cart_items.destroy_all

        # 注文完了画面のビューを表示
        redirect_to thanks_orders_path
      else
        # 保存に失敗した場合は入力画面に戻す
        render :new
      end
    end
  
    def thanks
      
    end
  
    def index
      @orders = current_customer.orders.all
    end
    
    def show
      # 特定の注文の取得
       @order = Order.find(params[:id])
    end
  
    private
  
    def order_params
      params.require(:order).permit(:payment_method, :delivery_address, :delivery_post_code, :delivery_name, :invoice_amount, :postage)
    end
end