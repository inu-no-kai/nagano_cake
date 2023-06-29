class Admin::OrderDetailsController < ApplicationController
  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = Order.find(@order_detail.order_id)
    @order_details = OrderDetail.where(order_id: @order.id)
    @order_detail.update(order_deteail_params)

  if @order_details.all? { |order_detail| order_detail.making_status == "completed_product" }
      @order.update(order_status: "sent")
  elsif @order_detail.making_status == "waiting_product"
      @order.update(order_status: "in_production")
  end
    redirect_to admin_order_path(@order.id)
  end

  private

  def order_deteail_params
    params.require(:order_detail).permit(:making_status)
  end
end
