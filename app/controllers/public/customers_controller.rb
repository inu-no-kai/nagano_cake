class Public::CustomersController < ApplicationController

<<<<<<< HEAD
=======
  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    customer = Customer.find(params[:id])
    customer.update(customer_params)
    redirect_to customer_path(customer.id)
  end

  def quit
    @customer = current_customer
  end

  def unsubscribe
    @customer = Customer.find(params[:id])
    @customer.update(is_delete: true)
    reset_session
    redirect_to root_path
  end
  private

  def customer_params
  	  params.require( :customer ).permit( :last_name, :first_name, :last_name_kana, :first_name_kana, :phone_number, :email, :password, :post_code, :address,:is_delete )
  end
>>>>>>> develop
end
