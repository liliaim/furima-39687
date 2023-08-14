class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_cost_burden
  belongs_to :prefecture
  belongs_to :days_until_shipment

  has_one_attached :image # 追加

  validates :image, presence: true
  validates :item_name, presence: true
  validates :item_description, presence: true

  # ジャンルの選択が「---」の時は保存できないようにする
  validates :category_id, numericality: { other_than: 1, message: 'を選択してください' }
  validates :condition_id, numericality: { other_than: 1, message: 'を選択してください' }
  validates :shipping_cost_burden_id, numericality: { other_than: 1, message: 'を選択してください' }
  validates :prefecture_id, numericality: { other_than: 1, message: 'を選択してください' }
  validates :days_until_shipment_id, numericality: { other_than: 1, message: 'を選択してください' }

  validates :price, presence: true
  validates :price, allow_blank: true,
                    numericality: { only_integer: true, in: 300..9_999_999, message: 'は¥300~¥9,999,999までの値を半角数値で入力してください' }

  belongs_to :user
  has_one :order
end
