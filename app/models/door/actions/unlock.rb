module Door
  module Actions
    class Unlock < Door::Actions::Action
      self.authorizer_name = 'DoorLatchAuthorizer'

      def backend_method
        :unlock!
      end
    end
  end
end
