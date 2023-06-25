class Public::AddressesController < ApplicationController
before_action :authenticate_customer!
before_action :is_matching_login_address, only: [:edit, :update]
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
    if @address.update(address_params)
       flash[:success] = "配送先の変更内容を保存しました。"
       redirect_to addresses_path
    else
       flash[:danger] = "配送先の変更内容に不備があります。"
       redirect_back(fallback_location: root_path)
    end
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
#ここがいまいちわからないので明日聞く
  def is_matching_login_address
    address = Address.find(params[:id])
    unless address.id == current_address.id
      redirect_to address_path
    end
  end

end
