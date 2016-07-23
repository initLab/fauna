class SpaceApi < OpenStruct
  include ActiveModel::Serializers::JSON
  include ActionView::Helpers::AssetUrlHelper

  def initialize
    super SPACEAPI_CONFIG
    self.api = '0.13'
    self.status = {open: hackerspace_open?}
    self.sensors = {}
    unless hackerspace_open?.nil?
      self.sensors[:door_locked] = {
                                    value: hackerspace_open? == false,
                                    location: 'Front'
                                   }
    end

    self.sensors[:present_users] = {value: Presence.present_users.count}

    if Presence.present_users.count > 0
      self.sensors[:present_users][:names] = Presence.present_users.map(&:name)
    end

  end

  def attributes
    to_h
  end

  private

  def hackerspace_open?
    case Door::CurrentStatus.new.latch
    when :unlocked
      true
    when :locked
      false
    else
      nil
    end
  end
end

# tsikov@gmail.com
