class Public::OrdersController < ApplicationController
    def new
      # 新しい注文のインスタンスを作成
      @order = Order.new
    end
   
    def confirm
      @order = Order.new(order_params)
      # 注文情報のバリデーションや他の処理を行う場合はここに記述します
      #@cart_items = current_customer.cart_items
      if @order.valid?
        # 注文情報が有効な場合の処理を記述します
        render :confirm # 確認画面のビューを表示します
      else
        # 注文情報が無効な場合の処理を記述します
        render :new # 入力画面のビューを再表示します
      end
    end
  
    def create
      # 注文の作成
      @order = Order.new(order_params)
      # 注文を保存するなどの処理を行う
      @order.postage = 800
      @order.invoice_amount = 0
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
        redirect_to orders_path
      else
        # 保存に失敗した場合は入力画面に戻す
        render :new
      end
    end
  
    def thanks
      @order = Order.find(params[:id])  # 注文情報を取得する例（idには注文IDを指定する必要があります）
    end
  
    def index
      @orders = Order.all
    end
    
    def show
      # 特定の注文の取得
      # @order = Order.find(params[:id])
    end
  
    private
  
    def order_params
      params.require(:order).permit(:payment_method, :delivery_address, :delivery_post_code, :delivery_name, :addresse)
    end
end