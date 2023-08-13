class OrdersController < ApplicationController
  before_action :authenticate_user!

  def index
    @item = Item.find(params[:item_id])
    if (current_user.id == @item.user_id) || (Order.find_by(item_id: @item.id))
      redirect_to root_path 
    end




    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    @item = Item.find(@order_address.item_id)

    if @order_address.valid?
      pay_item

      @order_address.save
      redirect_to root_path
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order_address).permit(:postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number,
                                          :item_id, :user_id).merge(token: params[:token])
  end

  def pay_item

    Payjp.api_key = ENV['PAYJP_SECRET_KEY'] 
    Payjp::Charge.create(
      amount: @item.price, # 商品の値段
      card: @order_address.token, # カードトークン
      currency: 'jpy' # 通貨の種類（日本円）
    )
  end

end
