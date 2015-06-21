class Door::StatusManager::Dummy
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
