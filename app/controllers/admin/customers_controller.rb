class Admin::CustomersController < ApplicationController
  
    def index
      @customers = Customer.page(params[:page]).per(10)
    end
    
    def show
      @customer = Customer.find(params[:id])
    end
    
    def edit
      @customer = Customer.find(params[:id])
    end
    
    def update
      @customer = Customer.find(params[:id])
      if @customer.update(customer_params)
        redirect_to admin_customer_path(@customer), notice: '会員情報を更新しました。'
      else
        render :edit
      end
    end
    
    private
  
    def customer_params
      params.require(:customer).permit(:last_name, :first_name, :post_code, :address, :phone_number, :email, :is_delete)
    end
end
