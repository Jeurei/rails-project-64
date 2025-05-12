# frozen_string_literal: true

class ApplicationController < ActionController::Base
  allow_browser versions: :modern

  before_action :set_locale

  private

  def set_locale
    I18n.locale = extract_locale || I18n.default_locale
  end

  def extract_locale
    parsed_locale = params[:locale] ||
                    request.env['HTTP_ACCEPT_LANGUAGE']&.scan(/^[a-z]{2}/)&.first
    I18n.available_locales.map(&:to_s).include?(parsed_locale) ? parsed_locale : nil
  end

  def default_url_options
    { locale: I18n.locale }
  end
end
