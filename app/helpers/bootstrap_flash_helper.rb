# frozen_string_literal: true

module BootstrapFlashHelper
  ALERT_TYPES_MAP = {
    notice: :success,
    alert: :danger,
    error: :danger,
    info: :info,
    warning: :warning
  }.freeze

  def bootstrap_flash
    safe_join(flash.each_with_object([]) do |(type, message), messages|
                next if message.blank? || !message.respond_to?(:to_str)

                type = ALERT_TYPES_MAP.fetch(type.to_sym, type)
                messages << flash_container(type, message)
              end, "\n").presence
  end

  def flash_container(type, message)
    content_tag :div, class: "card border-#{type}" do
      content_tag :div, class: 'card-body' do
        content_tag :div, class: 'card-text' do
          safe_concat(message)
        end
      end
    end
  end
end
