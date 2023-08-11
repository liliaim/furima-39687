class ItemsController < ApplicationController
  before_action :move_to_index, except: [:index, :show]
  before_action :set_item, only: [:edit, :show, :update]

  def index
    @items = Item.all.order(id: :DESC)
  end
  def new
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
  def show
  end
  def edit
    if user_signed_in? == false
      redirect_to new_user_session_path
    end
    unless current_user.id == @item.user_id
      redirect_to items_path
    end
  end
  def update

    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit, status: :unprocessable_entity, locals: { item: @item }
    end
  end

  private

  def item_params
    params.require(:item).permit(:item_name,:item_description,:category_id,:condition_id,:shipping_cost_burden_id,:prefecture_id,:days_until_shipment_id,:price,:image).merge(user_id: current_user.id)
  end
  def move_to_index
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end

  def set_item
    @item = Item.find(params[:id])
  end

end
