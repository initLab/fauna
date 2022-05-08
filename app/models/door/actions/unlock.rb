module Door
  module Actions
    class Unlock < Door::Actions::Action
      def backend_method
        :unlock!
      end
    end
  end
end
