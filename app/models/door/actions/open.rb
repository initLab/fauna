module Door
  module Actions
    class Open < Door::Actions::Action
      def backend_method
        :open!
      end
    end
  end
end
