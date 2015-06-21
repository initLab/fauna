module Door::Loggable
  extend ActiveSupport::Concern

  included do
    has_one :log_entry, as: :loggable
    before_create :associate_log_entry
  end

  private

  def associate_log_entry
    self.log_entry = build_log_entry
  end
end
