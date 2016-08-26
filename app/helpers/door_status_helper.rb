module DoorStatusHelper
  def door_status
    Door::CurrentStatus.new.latch
  end
end
