require "bcrypt"

class Api::PhoneAccessController < Api::ApplicationController
  wrap_parameters format: [:json]
  before_action -> { doorkeeper_authorize! :account_data_read }, only: [:verify_pin]

  def phone_number_token
    secret = Rails.application.credentials.phone.token_secret
    return head :internal_server_error unless secret

    phone_app_id = Rails.application.credentials.phone.app_id
    return head :internal_server_error unless phone_app_id

    return head :bad_request unless params[:phone_number]

    return head :forbidden unless ActiveSupport::SecurityUtils.secure_compare(params[:secret], secret)

    # TODO: the default country code should be taken from the model
    @user = User.joins(:phone_numbers).find_by phone_numbers: {phone_number: PhonyRails.normalize_number(params[:phone_number], default_country_code: "BG")}

    return head :not_found if @user.nil?

    @auth_token = Doorkeeper::AccessToken.find_or_create_for(
      application: Doorkeeper::Application.find(phone_app_id),
      resource_owner: @user.id,
      expires_in: 600,
      scopes: "account_data_read"
    )
  end

  def verify_pin
    return head :bad_request unless params[:pin]

    @valid = if current_resource_owner.encrypted_pin?
      (BCrypt::Password.new(current_resource_owner.encrypted_pin) == params[:pin]) ? "valid" : "invalid"
    else
      "not_set"
    end
  end
end
