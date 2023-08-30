class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :basic_auth
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :configure_account_update_parameters, if: :devise_controller? #編集機能について
  before_action :user_edit_action, only: [:edit], if: :devise_controller?

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']  # 環境変数を読み込む記述に変更
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [:nickname, :last_name, :first_name, :last_name_reading, :first_name_reading,
                                             :birth_date])
  end
  def configure_account_update_parameters
    devise_parameter_sanitizer.permit(:account_update,
      keys: [:nickname, :last_name, :first_name, :last_name_reading, :first_name_reading,
        :birth_date])

    
  end
  def user_edit_action
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    cards = Card.where(user_id: current_user.id).order(created_at: :desc)

    redirect_to new_card_path, turbo: "false" and return unless cards.present?

    latest_card = cards.first #最新のカード情報を取得する
    customer = Payjp::Customer.retrieve(latest_card.customer_token) # 先程のカード情報を元に、顧客情報を取得
    @card = customer.cards.first
  end
end
