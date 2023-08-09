class ItemsController < ApplicationController
  before_action :move_to_index, except: [:index, :show]

  def index
    @items = Item.all
  end
  def new
    # binding.pry

    @item = Item.new
  end
  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def item_params
    # binding.pry

    params.require(:item).permit(:item_name,:item_description,:category_id,:condition_id,:shipping_cost_burden_id,:prefecture_id,:days_until_shipment_id,:price,:image).merge(user_id: current_user.id)
  end
  def move_to_index
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end

end
