class User < ApplicationRecord
  validates :nickname, presence: true


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
         validate :password_complexity
         validates :last_name,:first_name,presence: true
         validates :last_name,:first_name,allow_blank: true, format: {with:/\A(?=.*?[ぁ-んァ-ヶ一-龥々ー]).{1,}\z/,message:"お名前は全角（漢字・ひらがな・カタカナ）での入力が必要です"}
         validates :last_name_reading,:first_name_reading, presence: true
         validates :last_name_reading,:first_name_reading,allow_blank: true, format: {with:/\A(?=.*?[ァ-ヶー]).{1,}\z/,message:"お名前カナは全角（カタカナ）での入力が必要です"}
         validates :birth_date, presence: true
       
  private

  def password_complexity
    # パスワードの複雑さ要件をここに正規表現を使って追加します
    # 例として、以下の正規表現は、少なくとも1つの大文字、1つの小文字、1つの数字、1つの特殊文字を必要とし、パスワードの長さは8から70文字であることを要件とします
    # complexity_regex = /^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,70}$/
    complexity_regex = /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i

    # return if password.blank? || password =~ complexity_regex
    return if password.blank? || password =~ complexity_regex

    errors.add :password, 'パスワードは半角英数字混合である必要があります'
  end
end
