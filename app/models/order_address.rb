class OrderAddress
  include ActiveModel::Model
  attr_accessor :item_id, :user_id, :postal_code, :prefecture_id, :city, :house_number, :building_name, :phone_number, :order_id,
                :token

  validates :token, :postal_code, presence: true
  validates :postal_code, allow_blank: true,
                          format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: 'はハイフンを含んだ形式で入力してください(例:123-4567)' }

  validates :prefecture_id, numericality: { other_than: 1, message: 'を選択してください' }
  validates :city, :house_number, :phone_number, :item_id, :user_id, presence: true
  validates :phone_number, allow_blank: true, format: { with: /\A\d{10,11}\z/, message: 'は、ハイフンなし10桁or11桁の半角数値のみを入力してください' }

  def save
    order = Order.create(item_id:, user_id:)

    Address.create(postal_code:, prefecture_id:, city:, house_number:,
                   building_name:, phone_number:, order_id: order.id)
  end
end
