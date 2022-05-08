module Door
  module Actions
    class Lock < Door::Actions::Action
      def backend_method
        :lock!
      end
    end
  end
end 
