class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_cost_burden
  belongs_to :prefecture
  belongs_to :days_until_shipment

  has_one_attached :image #追加
  
  validates :image, presence: true
  validates :item_name, presence: true
  validates :item_description, presence: true

  #ジャンルの選択が「---」の時は保存できないようにする
  validates :category_id            , numericality: { other_than: 1  , message: "カテゴリーを選択してください"} 
  validates :condition_id           , numericality: { other_than: 1  , message: "商品の状態を選択してください"} 
  validates :shipping_cost_burden_id, numericality: { other_than: 1  , message: "配送料の負担を選択してください"} 
  validates :prefecture_id          , numericality: { other_than: 1  , message: "発送元の地域を選択してください"} 
  validates :days_until_shipment_id , numericality: { other_than: 1  , message: "発送までの日数を選択してください"} 

  validates :price, presence: true
  validates :price, allow_blank: true, numericality: { in: 300..9999999 , message: "価格は¥300~¥9,999,999までの値を半角数値で入力してください"}

  belongs_to :user
end
