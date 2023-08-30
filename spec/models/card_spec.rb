require 'rails_helper'

RSpec.describe Card, type: :model do
  describe 'カード登録' do
    before do
      user = FactoryBot.create(:user)
      @card = FactoryBot.build(:card, user_id: user.id)
    end

    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@card).to be_valid
      end
    end

    context '内容に問題がある場合' do
      it 'tokenが空では登録できないこと' do
        @card.token = ''
        @card.valid?
        expect(@card.errors.full_messages).to include('トークンを入力してください')
      end
      it 'userが紐付いていないと保存できないこと' do
        @card.user_id = nil
        @card.valid?
        expect(@card.errors.full_messages).to include('Userを入力してください')
      end
    end
  end
end
