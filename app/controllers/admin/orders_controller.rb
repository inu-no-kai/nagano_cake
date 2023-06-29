class Admin::OrdersController < ApplicationController

  def show
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: @order.id)
  end

  def update
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: @order.id)
    @order.update(order_params)

    if @order.order_status == "payment_confirmation"
      @order_details.each do |order_detail|
        order_detail.update(making_status: "producting")
      end
    end

    redirect_to admin_order_path(@order.id)
  end


  private

  def order_params
    params.require(:order).permit(:payment_method, :customer_id, :delivery_post_code, :delivery_address, :delivery_name ,:postage ,:invoice_amount,:order_status)
  end

end