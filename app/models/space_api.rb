class SpaceApi < OpenStruct
  include ActiveModel::Serializers::JSON
  include ActionView::Helpers::AssetUrlHelper

  def initialize
    super SPACEAPI_CONFIG
    self.api = '0.13'
    set_hackerspace_state
    set_lights_status
    add_front_door_status_if_known
    add_people_now_present
  end

  def attributes
    to_h
  end

  private

  def add_sensor(name:, data:)
    self.sensors ||= {}
    self.sensors[name] ||= []

    self.sensors[name] << data
  end

  def add_front_door_status_if_known
    return if hackerspace_open?.nil?
    add_sensor name: :door_locked, data: {value: !hackerspace_open?,
                                          location: 'Front'}
  end

  def add_people_now_present
    present_people_reading = {location: SPACEAPI_CONFIG['space'],
                              value: Presence.present_users.count}

    if Presence.present_users.count > 0
      present_people_reading[:names] = Presence.present_users.map(&:name)
    end

    add_sensor name: :people_now_present, data: present_people_reading
  end

  def set_hackerspace_state
    self.state = {open: hackerspace_open?}
  end

  def set_lights_status
    return if lights_on?.nil?
    add_sensor name: :ext_lights_on, data: {value: lights_on?,
                                            location: 'Outside'}
  end

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

  def lights_on?
    begin
      case Rails.application.config.lights_policy_manager.new.status
      when :on
        true
      when :off
        false
      end
    rescue Lights::PolicyManager::Error
    end
  end
end
