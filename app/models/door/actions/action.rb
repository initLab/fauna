module Door
  module Actions
    class Action < ApplicationRecord
      include Door::Loggable

      belongs_to :initiator, class_name: 'User'

      after_create :execute!

      def self.from_name(name)
        {
          open: Door::Actions::Open,
          lock: Door::Actions::Lock,
          unlock: Door::Actions::Unlock
        }[name.to_sym].try(:new)
      end

      def to_s
        self.class.model_name.human
      end

      def public_message
        initiator_name = 'Somebody'

        if initiator.present?
          if initiator.announce_my_presence
            initiator_name = initiator.username
          else
            initiator_name = 'Somebody who does not wish to be named'
          end
        end

        "#{initiator_name} requested the door be #{self.class.model_name.human(locale: :en).downcase}ed"
      end

      private

      def execute!
        update execution_succeeded: status_manager.public_send(self.backend_method)
        true
      end

      def status_manager
        Rails.application.config.door_status_manager.backend
      end
    end
  end
end
