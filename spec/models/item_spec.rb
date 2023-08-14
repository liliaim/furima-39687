require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
  end
  describe '商品出品' do
    context '新規出品できる場合' do
      it '全ての項目の値が存在すれば作成できる' do
        expect(@item).to be_valid
      end
    end
    context '新規作成できない場合' do
      it 'imageが空では作成できない' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("画像を入力してください")
      end
      it 'item_nameが空では作成できない' do
        @item.item_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end
      it 'item_descriptionが空では作成できない' do
        @item.item_description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の説明を入力してください")
      end
      it 'category_idが空では作成できない' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('カテゴリーを選択してください')
      end
      it 'condition_idが空では作成できない' do
        @item.condition_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('商品の状態を選択してください')
      end
      it 'shipping_cost_burden_idが空では作成できない' do
        @item.shipping_cost_burden_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('配送料の負担を選択してください')
      end
      it 'prefecture_idが空では作成できない' do
        @item.prefecture_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('発送元の地域を選択してください')
      end
      it 'days_until_shipment_idが空では作成できない' do
        @item.days_until_shipment_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include('発送までの日数を選択してください')
      end
      it 'category_idが「---」では作成できない' do
        @item.category_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('カテゴリーを選択してください')
      end
      it 'condition_idが「---」では作成できない' do
        @item.condition_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('商品の状態を選択してください')
      end
      it 'shipping_cost_burden_idが「---」では作成できない' do
        @item.shipping_cost_burden_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('配送料の負担を選択してください')
      end
      it 'prefecture_idが「---」では作成できない' do
        @item.prefecture_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('発送元の地域を選択してください')
      end
      it 'days_until_shipment_idが「---」では作成できない' do
        @item.days_until_shipment_id = 1
        @item.valid?
        expect(@item.errors.full_messages).to include('発送までの日数を選択してください')
      end
      it 'priceが空では作成できない' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格を入力してください")
      end
      it 'priceが300円未満では出品できない' do
        @item.price = 30
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は¥300~¥9,999,999までの値を半角数値で入力してください')
      end
      it 'priceが9,999,999円を超えると出品できない' do
        @item.price = 10_000_000
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は¥300~¥9,999,999までの値を半角数値で入力してください')
      end
      it 'priceが半角数値でないと作成できない' do
        @item.price = '３０００'
        @item.valid?
        expect(@item.errors.full_messages).to include('販売価格は¥300~¥9,999,999までの値を半角数値で入力してください')
      end
      it 'userが紐付いていないと保存できない' do
        @item.user = nil
        @item.valid?
        expect(@item.errors.full_messages).to include('Userを入力してください')
      end
    end
  end
end
