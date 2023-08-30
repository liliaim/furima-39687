class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only: [:index, :create]
  before_action :show_card_info, only: [:index]

  def index
    redirect_to root_path if (current_user.id == @item.user_id) || Order.find_by(item_id: @item.id)

    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    if @order_address.valid?
      pay_item

      @order_address.save
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render :index, locals: { item_id: @item.id }, status: :unprocessable_entity
    end
  end

  private

  def order_params
    params.require(:order_address).permit(:postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number, :user_id).merge(
      token: params[:token], item_id: params[:item_id]
    )
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    customer_token = current_user.card.customer_token # ログインしているユーザーの顧客トークンを定義
    Payjp::Charge.create(
      amount: @item.price, # 商品の値段
      # card: @order_address.token, # カードトークン
      customer: customer_token, # 顧客のトークン
      currency: 'jpy' # 通貨の種類（日本円）
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def show_card_info
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    cards = Card.where(user_id: current_user.id).order(created_at: :desc)

    redirect_to new_card_path, turbo: 'false' and return unless cards.present?

    latest_card = cards.first # 最新のカード情報を取得する
    customer = Payjp::Customer.retrieve(latest_card.customer_token) # 先程のカード情報を元に、顧客情報を取得
    @card = customer.cards.first
    # binding.pry
  end
end
