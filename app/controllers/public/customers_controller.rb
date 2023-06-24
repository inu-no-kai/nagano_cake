class Public::CustomersController < ApplicationController
  def show
    @customer = Customer.find(params[:id])
  end
  def edit
    @customer = Customer.find(params[:id])
  end
  private

  def customer_params
  	  params.require( :customer ).permit( :last_name, :first_name, :last_name_kana, :first_name_kana, :phone_number, :email, :password, :post_code, :address )
  end
end
