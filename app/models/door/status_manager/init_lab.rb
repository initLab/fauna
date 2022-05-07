module Door
  module StatusManager
    class InitLab
      extend Forwardable

      def initialize
        @opener = Door::StatusManager::Buzzer.new
        @locker = Door::StatusManager::Pesho.new
      end

      def_delegator :@opener, :open!
      def_delegators :@locker, :status, :unlock!, :lock!
    end
  end
end
