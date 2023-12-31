class Public::AddressesController < ApplicationController
before_action :authenticate_customer!

  def index
    @address = Address.new
    @customer = current_customer
    @addresses = current_customer.addresses
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
      flash[:success] = "新しい配送先の登録が完了しました。"
      redirect_to addresses_path
    else
      @customer = current_customer
      @addresses = @customer.addresses
      flash[:danger] = "新しい配送先内容に不備があります。"
      redirect_back(fallback_location: root_path)
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    @address.update(address_params)
    redirect_to addresses_path
  end

  def destroy
    @address = Address.find(params[:id])
    @address.customer_id = current_customer.id
    @address.destroy
    flash[:success] = "配送先の削除が完了しました。"
    redirect_to addresses_path
  end



  private
  def address_params
    params.require(:address).permit(:post_code, :address, :name)
  end

end
