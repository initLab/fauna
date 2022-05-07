module Door
  module Actions
    class Open < Door::Actions::Action
      self.authorizer_name = 'DoorHandleAuthorizer'

      def backend_method
        :open!
      end
    end
  end
end
