class ApplicationController < ActionController::Base
  include Pundit::Authorization

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  def self.default_url_options(options = {})
    if I18n.locale != I18n.default_locale
      options.merge({locale: I18n.locale})
    else
      options
    end
  end

  protected

  def requested_locale
    if user_signed_in?
      current_user.locale
    elsif params[:locale].present? && I18n.available_locales.include?(params[:locale].to_sym)
      params[:locale].to_sym
    end
  end

  def set_locale
    I18n.locale = requested_locale || I18n.default_locale
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :username, :email])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :username,
      :email, :url, :locale,
      :twitter, :announce_my_presence,
      :github, :jabber,
      :gpg_fingerprint,
      :pin, :pin_confirmation,
      phone_numbers_attributes: [
        :_destroy,
        :id,
        :phone_number
      ]])
  end

  def current_ip_address
    request.env["HTTP_X_FORWARDED_FOR"] || request.remote_ip
  end

  def current_mac_address
    Arp.mac_by_ip_address(current_ip_address)
  end
end
