class Door::StatusManager::Buzzer
  def open!
    Kernel.system 'openr1'
  end

  [:status, :lock!, :unlock!].each do |method_name|
    define_method(method_name) do
      raise NotImplementedError.new "#{self.class} does not implement the ##{method_name.to_s} method"
    end
  end
end
