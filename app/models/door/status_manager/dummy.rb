module Door
  module StatusManager
    class Dummy
      def status
        {"door" => "closed", "latch" => "locked"}
      end

      def unlock!
        true
      end

      def lock!
        true
      end

      def open!
        true
      end
    end
  end
end
